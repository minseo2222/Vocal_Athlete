"""Fail when the checked-in Android release foundation regresses."""

from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "app"
EXPECTED_ID = "com.vocalathlete.vocal_athlete"
EXPECTED_ACTIVITY = (
    APP
    / "android/app/src/main/kotlin/com/vocalathlete/vocal_athlete/MainActivity.kt"
)


def require(condition: bool, message: str, failures: list[str]) -> None:
    if not condition:
        failures.append(message)


def main() -> int:
    failures: list[str] = []
    gradle = (APP / "android/app/build.gradle.kts").read_text(encoding="utf-8")
    android_ignore = (APP / "android/.gitignore").read_text(encoding="utf-8")
    pubspec = (APP / "pubspec.yaml").read_text(encoding="utf-8")

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
    require("key.properties" in android_ignore, "key.properties is not ignored", failures)
    require("**/*.jks" in android_ignore, "JKS files are not ignored", failures)
    require("**/*.keystore" in android_ignore, "keystore files are not ignored", failures)
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
