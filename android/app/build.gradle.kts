import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// .env 파일을 읽기 위한 로직
val envProps = Properties()
listOf(
    rootProject.file("../.env"),   // 프로젝트 루트 .env
    rootProject.file(".env")       // android/.env
).firstOrNull { it.exists() }?.reader(Charsets.UTF_8)?.use { envProps.load(it) }

fun readMapsKey(): String =
    (envProps.getProperty("GOOGLE_MAPS_API_KEY")
        ?: System.getenv("GOOGLE_MAPS_API_KEY")
        ?: "")
        .trim()
        .removePrefix("export ")
        .removePrefix("GOOGLE_MAPS_API_KEY=")
        .removeSurrounding("\"")

android {
    namespace = "com.example.eum_demo"
    compileSdk = 35  // 36에서 35로 변경
    buildToolsVersion = "35.0.0"  // 안정 버전 명시
    ndkVersion = "27.0.12077973"

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.eum_demo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdkVersion (flutter.minSdkVersion)
        targetSdk = 35  // 36에서 35로 변경
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // .env → Manifest placeholder 주입
        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = readMapsKey()
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }
}

flutter {
    source = "../.."
}
