plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// local.properties okuma kısmı genellikle flutter eklentisi tarafından halledilir.
// Bu yüzden o karmaşık fonksiyon bloğunu tamamen kaldırıyoruz.

android {
    namespace = "com.example.to_do_app"
    // flutter.compileSdkVersion'a doğrudan erişim genellikle çalışır.
    compileSdk = flutter.compileSdkVersion 

    compileOptions {
        // Core library desugaring'i Kotlin DSL'de bu şekilde aktif ediyoruz.
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.example.to_do_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = 1 // Buraya doğrudan bir değer verebiliriz veya flutter eklentisine bırakabiliriz.
        versionName = "1.0" // Buraya doğrudan bir değer verebiliriz.
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Desugaring kütüphanesini bağımlılıklara ekliyoruz.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}