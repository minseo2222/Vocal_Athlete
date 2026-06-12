import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val releaseKeystorePropertiesFile = rootProject.file("key.properties")
val releaseKeystoreProperties =
    Properties().apply {
        if (releaseKeystorePropertiesFile.exists()) {
            releaseKeystorePropertiesFile.inputStream().use { load(it) }
        }
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
        create("release") {
            keyAlias = releaseKeystoreProperties.getProperty("keyAlias")
            keyPassword = releaseKeystoreProperties.getProperty("keyPassword")
            storePassword = releaseKeystoreProperties.getProperty("storePassword")
            val storeFilePath = releaseKeystoreProperties.getProperty("storeFile")
            if (!storeFilePath.isNullOrBlank()) {
                storeFile = rootProject.file(storeFilePath)
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

tasks.register("validateReleaseSigning") {
    doLast {
        val requiredKeys = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
        val missingKeys =
            requiredKeys.filter {
                releaseKeystoreProperties.getProperty(it).isNullOrBlank()
            }
        if (!releaseKeystorePropertiesFile.exists() || missingKeys.isNotEmpty()) {
            throw GradleException(
                "Release signing is not configured. Copy app/android/key.properties.example " +
                    "to app/android/key.properties and provide local keystore values. " +
                    "Missing keys: ${missingKeys.joinToString(", ")}"
            )
        }
        val storeFilePath = releaseKeystoreProperties.getProperty("storeFile")
        val resolvedStoreFile = rootProject.file(storeFilePath)
        if (!resolvedStoreFile.exists()) {
            throw GradleException("Release keystore not found: ${resolvedStoreFile.path}")
        }
    }
}

tasks.matching { it.name in listOf("assembleRelease", "bundleRelease") }
    .configureEach { dependsOn("validateReleaseSigning") }

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
