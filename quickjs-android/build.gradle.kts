plugins {
    alias(libs.plugins.androidLibrary)
    alias(libs.plugins.kotlinAndroid)
    id("maven-publish")
}

/*
 * Uploading QuickJS artifact to central repo (Currently publishing to Github Packages) has
 * been written in upload-quickjs.gradle.kts script.
 * Enable below plugin If you wish to push the new version and run the gradle command
 * ./gradlew publishQuickJSPublicationToGitHubPackagesRepository
 *
 * QuickJS version is maintained in libs.versions.toml as quickjs
 */
// apply(from = "upload-quickjs.gradle.kts")

android {
    namespace = "com.shiqi.quickjs"
    compileSdk = 36
    ndkVersion = "28.0.12916984"

    defaultConfig {
        minSdk = 24

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables {
            useSupportLibrary = true
        }

        externalNativeBuild {
            cmake {
                targets.add("quickjs-android")
                arguments += listOf("-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON")
            }
        }
        ndk {
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
        }
    }

    externalNativeBuild {
        cmake {
            path = file("CMakeLists.txt")
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            isMinifyEnabled = false
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    packagingOptions {
        resources {
            excludes += listOf("/META-INF/{AL2.0,LGPL2.1}")
        }
    }
}

dependencies {
    implementation("androidx.annotation:annotation:1.6.0")
}
