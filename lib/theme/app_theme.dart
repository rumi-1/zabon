import 'package:flutter/material.dart';

/// Duolingo-style greens + Roshan navy/gold/cream identity.
class AppTheme {
  /// Primary action / streak energy (Duolingo lane).
  static const Color leaf = Color(0xFF58CC02);
  static const Color leafDark = Color(0xFF46A302);

  /// Accent — ties to original Zabon sky/links.
  static const Color sky = Color(0xFF1CB0F6);

  /// Original Zabon hero navy & gold.
  static const Color zabonNavy = Color(0xFF1A3A5C);
  static const Color zabonGold = Color(0xFFC9922A);

  /// Warm paper — matches `RoshanApp` cream scaffold.
  static const Color paper = Color(0xFFFBF6EE);
  static const Color ink = Color(0xFF2C3E50);

  static ThemeData zabonLight() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: leaf,
        brightness: Brightness.light,
        primary: leaf,
        onPrimary: Colors.white,
        secondary: zabonNavy,
        surface: Colors.white,
      ),
    );
    return base.copyWith(
      scaffoldBackgroundColor: paper,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: zabonNavy,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: leaf,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 0.3,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: paper,
        selectedItemColor: leafDark,
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static LinearGradient pathGradient(bool unlocked) {
    return LinearGradient(
      colors: unlocked
          ? [leaf.withValues(alpha: 0.28), sky.withValues(alpha: 0.18)]
          : [Colors.grey.shade300, Colors.grey.shade200],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient heroGradient() {
    return const LinearGradient(
      colors: [zabonNavy, Color(0xFF243E5C)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
