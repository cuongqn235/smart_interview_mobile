import 'package:flutter/material.dart';

abstract class AppStyles {
  // Body Styles
  static TextStyle get bodyLarge => const TextStyle(
        fontSize: 16.0,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: 14.0,
        height: 1.4,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 12.0,
        height: 1.3,
      );

  // Display Styles
  static TextStyle get displayLarge => const TextStyle(
        fontSize: 57.0,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get displaySmall => const TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
      );

  // Headline Styles
  static TextStyle get headlineLarge => const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headlineMedium => const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headlineSmall => const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      );

  // Label Styles
  static TextStyle get labelLarge => const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
      );

  // Title Styles
  static TextStyle get titleLarge => const TextStyle(
        fontSize: 22.0,
        fontStyle: FontStyle.italic,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      );

  // Helper methods for common style variations
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }

  static TextStyle withWeight(TextStyle style, FontWeight fontWeight) {
    return style.copyWith(fontWeight: fontWeight);
  }
}
