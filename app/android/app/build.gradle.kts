import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use(keystoreProperties::load)
}

val requiredSigningProperties = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
val missingSigningProperties =
    requiredSigningProperties.filter { keystoreProperties.getProperty(it).isNullOrBlank() }
val configuredStoreFile = keystoreProperties.getProperty("storeFile")?.let(::file)
val releaseSigningReady =
    keystorePropertiesFile.exists() &&
        missingSigningProperties.isEmpty() &&
        configuredStoreFile?.isFile == true
val releaseTaskRequested =
    gradle.startParameter.taskNames.any { it.contains("release", ignoreCase = true) }

if (releaseTaskRequested && !releaseSigningReady) {
    val reason =
        when {
            !keystorePropertiesFile.exists() -> "android/key.properties does not exist"
            missingSigningProperties.isNotEmpty() ->
                "android/key.properties is missing: ${missingSigningProperties.joinToString()}"
            else -> "the storeFile configured in android/key.properties does not exist"
        }
    throw GradleException(
        "Release signing is not configured: $reason. " +
            "Follow docs/release/ANDROID-RELEASE-FOUNDATION.md; debug signing is never used for release builds.",
    )
}

android {
    namespace = "com.vocalathlete.vocal_athlete"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.vocalathlete.vocal_athlete"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (releaseSigningReady) {
            create("release") {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = configuredStoreFile
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            if (releaseSigningReady) {
                signingConfig = signingConfigs.getByName("release")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
