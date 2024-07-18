# Contoh aturan dasar untuk proguard-rules.pro

# Jangan obfuscate semua kelas di package com.example
-keep class com.example.** { *; }

# Jangan obfuscate semua interface di package com.example
-keep interface com.example.** { *; }

# Jangan obfuscate semua kelas di package com.google
-keep class com.google.** { *; }

# Jangan obfuscate kelas dan method tertentu (contoh)
-keepclassmembers class * {
    public static void main(java.lang.String[]);
}

# Jangan obfuscate semua enum
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
