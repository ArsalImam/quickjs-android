# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# ProGuard rules for quickjs-android library
# https://github.com/seven332/quickjs-android

# Keep all native methods - they are called from JNI
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep QuickJS main classes and their methods
# Adjust the package name if different in your version
-keep class com.shiqi.quickjs.** { *; }

# Keep JSContext and related classes as they're likely accessed from native code
-keep class * extends com.shiqi.quickjs.JSContext { *; }

# Keep all classes that might be instantiated from native code
-keepclassmembers class * {
    @com.shiqi.quickjs.JSMethod *;
}

# Keep JavaScript function interfaces and callbacks
-keep interface com.shiqi.quickjs.JSFunction { *; }
-keep class * implements com.shiqi.quickjs.JSFunction { *; }

# Keep any classes with JSObject annotations or similar
-keepclassmembers class * {
    @**.JSObject *;
    @**.JSFunction *;
    @**.JSMethod *;
}

# Preserve method signatures for methods that might be called from JS
-keepclassmembers class * {
    public *;
    protected *;
}

# Keep exceptions that might be thrown to/from native code
-keep class com.shiqi.quickjs.JSException { *; }
-keep class * extends com.shiqi.quickjs.JSException { *; }

# Keep line numbers and source file names for debugging
-keepattributes SourceFile,LineNumberTable

# Keep generic signatures for reflection
-keepattributes Signature

# Keep annotations that might be used by the library
-keepattributes *Annotation*

# If you're using any custom JavaScript interfaces, keep them
# Replace 'your.package.name' with your actual package
# -keep class your.package.name.YourJSInterface { *; }

# Additional safety rules for JNI callbacks
-keepclassmembers class * {
    void onResult(...);
    void onError(...);
    void callback(...);
}