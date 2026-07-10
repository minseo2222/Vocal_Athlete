"""Fail when the checked-in Android release foundation regresses."""

from pathlib import Path
import re
import subprocess
import sys
import zipfile


ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "app"
EXPECTED_ID = "com.vocalathlete.vocal_athlete"
EXPECTED_ACTIVITY = (
    APP
    / "android/app/src/main/kotlin/com/vocalathlete/vocal_athlete/MainActivity.kt"
)
WRAPPER_FILES = (
    "app/android/gradlew",
    "app/android/gradlew.bat",
    "app/android/gradle/wrapper/gradle-wrapper.jar",
    "app/android/gradle/wrapper/gradle-wrapper.properties",
)
WORKFLOW_PATH = ROOT / ".github/workflows/flutter-validation.yml"


def require(condition: bool, message: str, failures: list[str]) -> None:
    if not condition:
        failures.append(message)


def git_index_entries(failures: list[str]) -> dict[str, str]:
    try:
        result = subprocess.run(
            ["git", "-C", str(ROOT), "ls-files", "--stage", "--", *WRAPPER_FILES],
            check=False,
            capture_output=True,
            text=True,
            encoding="utf-8",
        )
    except FileNotFoundError:
        failures.append(
            "Git executable is unavailable; wrapper tracking and executable mode cannot be verified"
        )
        return {}

    if result.returncode != 0:
        detail = result.stderr.strip() or "git ls-files failed"
        failures.append(
            f"Git index is unavailable; wrapper tracking cannot be verified: {detail}"
        )
        return {}

    entries: dict[str, str] = {}
    for line in result.stdout.splitlines():
        metadata, path = line.split("\t", maxsplit=1)
        mode = metadata.split(maxsplit=1)[0]
        entries[path.replace("\\", "/")] = mode
    return entries


def main() -> int:
    failures: list[str] = []
    gradle = (APP / "android/app/build.gradle.kts").read_text(encoding="utf-8")
    android_ignore = (APP / "android/.gitignore").read_text(encoding="utf-8")
    android_ignore_rules = {
        line.strip()
        for line in android_ignore.splitlines()
        if line.strip() and not line.lstrip().startswith("#")
    }
    pubspec = (APP / "pubspec.yaml").read_text(encoding="utf-8")
    workflow = WORKFLOW_PATH.read_text(encoding="utf-8")

    for wrapper_path in WRAPPER_FILES:
        require(
            (ROOT / wrapper_path).is_file(),
            f"required Gradle Wrapper file is missing: {wrapper_path}",
            failures,
        )

    index_entries = git_index_entries(failures)
    for wrapper_path in WRAPPER_FILES:
        require(
            wrapper_path in index_entries,
            f"required Gradle Wrapper file is not tracked by Git: {wrapper_path}",
            failures,
        )
    if "app/android/gradlew" in index_entries:
        require(
            index_entries["app/android/gradlew"] == "100755",
            "app/android/gradlew must be tracked with executable mode 100755",
            failures,
        )

    wrapper_jar = APP / "android/gradle/wrapper/gradle-wrapper.jar"
    if wrapper_jar.is_file():
        require(
            zipfile.is_zipfile(wrapper_jar),
            "Gradle Wrapper JAR is not a valid ZIP/JAR file",
            failures,
        )
        if zipfile.is_zipfile(wrapper_jar):
            with zipfile.ZipFile(wrapper_jar) as jar:
                require(
                    "org/gradle/wrapper/GradleWrapperMain.class" in jar.namelist(),
                    "Gradle Wrapper JAR does not contain GradleWrapperMain",
                    failures,
                )

    require(
        "working-directory: app/android" in workflow
        and "run: ./gradlew signingReport" in workflow,
        "CI signingReport must invoke the tracked app/android/gradlew path",
        failures,
    )

    namespace = re.search(r'namespace\s*=\s*"([^"]+)"', gradle)
    application_id = re.search(r'applicationId\s*=\s*"([^"]+)"', gradle)
    require(namespace is not None, "Gradle namespace is missing", failures)
    require(application_id is not None, "Gradle applicationId is missing", failures)
    if namespace and application_id:
        require(namespace.group(1) == EXPECTED_ID, "namespace changed unexpectedly", failures)
        require(application_id.group(1) == EXPECTED_ID, "applicationId changed unexpectedly", failures)
        require(namespace.group(1) == application_id.group(1), "namespace and applicationId differ", failures)

    require(EXPECTED_ACTIVITY.is_file(), "MainActivity is not in the namespace directory", failures)
    if EXPECTED_ACTIVITY.is_file():
        activity = EXPECTED_ACTIVITY.read_text(encoding="utf-8")
        require(
            f"package {EXPECTED_ID}" in activity,
            "MainActivity package does not match the namespace",
            failures,
        )

    require(
        'signingConfigs.getByName("debug")' not in gradle,
        "release configuration references the debug signing config",
        failures,
    )
    require('create("release")' in gradle, "release signing config is missing", failures)
    require(
        "releaseTaskRequested && !releaseSigningReady" in gradle,
        "missing release credentials are not rejected",
        failures,
    )
    require("key.properties" in android_ignore_rules, "key.properties is not ignored", failures)
    require("**/*.jks" in android_ignore_rules, "JKS files are not ignored", failures)
    require("**/*.keystore" in android_ignore_rules, "keystore files are not ignored", failures)
    require(
        "app/android/key.properties" in workflow
        and '"$RUNNER_TEMP/ci-release.jks"' in workflow,
        "CI must create and clean up both disposable signing files",
        failures,
    )
    require("if: always()" in workflow, "CI signing cleanup must run with if: always()", failures)
    require(
        'description: "A new Flutter project."' not in pubspec,
        "pubspec still has the Flutter template description",
        failures,
    )

    if failures:
        for failure in failures:
            print(f"ERROR: {failure}", file=sys.stderr)
        return 1
    print("Android release foundation verified.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
