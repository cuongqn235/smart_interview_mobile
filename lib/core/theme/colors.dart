import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6D5FFF);
  static const Color primaryLight = Color(0xFF8B7FFF);
  static const Color primaryDark = Color(0xFF5A4FD9);

  // Secondary Colors
  static const Color secondary = Color(0xFF46C2CB);
  static const Color secondaryLight = Color(0xFF6BD4DC);
  static const Color secondaryDark = Color(0xFF3A9FA7);

  // Background Gradients
  static const Color backgroundDark1 = Color(0xFF1a1a2e);
  static const Color backgroundDark2 = Color(0xFF16213e);
  static const Color backgroundDark3 = Color(0xFF0f3460);

  // Splash Screen Colors
  static const Color splashIndigo = Color(0xFF312E81);
  static const Color splashPurple = Color(0xFF581C87);
  static const Color splashPink = Color(0xFF9F1239);

  // Material Colors Extensions
  static const Color purple = Colors.purple;
  static const Color blue = Colors.blue;
  static const Color green = Colors.green;
  static const Color teal = Colors.teal;
  static const Color cyan = Colors.cyan;
  static const Color amber = Colors.amber;
  static const Color yellow = Colors.yellow;
  static const Color orange = Colors.orange;
  static const Color red = Colors.red;
  static const Color pink = Colors.pink;

  // Specific Hex Colors
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue700 = Color(0xFF1D4ED8);
  static const Color indigo500 = Color(0xFF4F46E5);
  static const Color indigo600 = Color(0xFF4338CA);

  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color purple600 = Color(0xFF7C3AED);
  static const Color purple700 = Color(0xFF6D28D9);

  static const Color pink500 = Color(0xFFEC4899);
  static const Color pink600 = Color(0xFFDB2777);

  static const Color green500 = Color(0xFF10B981);
  static const Color green600 = Color(0xFF059669);

  static const Color orange500 = Color(0xFFF97316);
  static const Color orange600 = Color(0xFFEA580C);

  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber500 = Color(0xFFF59E0B);

  static const Color cyan500 = Color(0xFF06B6D4);

  // Background Light Colors
  static const Color lightBlue50 = Color(0xFFEFF6FF);
  static const Color lightBlue100 = Color(0xFFE0E7FF);
  static const Color lightPurple50 = Color(0xFFFAF5FF);
  static const Color lightPurple100 = Color(0xFFFDF2F8);
  static const Color lightGreen50 = Color(0xFFECFDF5);
  static const Color lightGreen100 = Color(0xFFD1FAE5);
  static const Color lightOrange50 = Color(0xFFFFF7ED);
  static const Color lightRed50 = Color(0xFFFEF2F2);

  // White with opacity variations
  static Color white10 = Colors.white.withOpacity(0.1);
  static Color white20 = Colors.white.withOpacity(0.2);
  static Color white30 = Colors.white.withOpacity(0.3);
  static Color white40 = Colors.white.withOpacity(0.4);
  static Color white50 = Colors.white.withOpacity(0.5);
  static Color white60 = Colors.white.withOpacity(0.6);
  static Color white70 = Colors.white.withOpacity(0.7);
  static Color white80 = Colors.white.withOpacity(0.8);
  static Color white85 = Colors.white.withOpacity(0.85);

  // Black with opacity variations
  static Color black10 = Colors.black.withOpacity(0.1);
  static Color black20 = Colors.black.withOpacity(0.2);
  static Color black26 = Colors.black26;

  // Common Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [purple, blue],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [green, teal],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [backgroundDark1, backgroundDark2, backgroundDark3],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [splashIndigo, splashPurple, splashPink],
  );

  static const LinearGradient loginGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  // Feature Gradients
  static const LinearGradient blueGradient = LinearGradient(
    colors: [blue500, cyan500],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [purple500, pink500],
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [green500, green600],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [amber500, orange600],
  );

  // Brain Animation Colors
  static const LinearGradient brainOrangeGradient = LinearGradient(
    colors: [amber400, orange600],
  );

  static const LinearGradient brainPurpleGradient = LinearGradient(
    colors: [purple500, blue500],
  );
}
