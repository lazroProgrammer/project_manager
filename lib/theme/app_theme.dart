import 'package:flutter/material.dart';

Color adjustBrightness(Color color,
    {required bool isDarkMode, double? brightness}) {
  // Convert the color to HSL
  HSLColor hsl = HSLColor.fromColor(color);

  // If dark mode, decrease lightness; if light mode, increase lightness
  double adjustedLightness = isDarkMode
      ? 1 - hsl.lightness // Invert the lightness for dark mode
      : hsl.lightness; // Reduce the lightness for light mode (10% of original)
  if (brightness != null) {
    adjustedLightness = brightness;
  }
  // Ensure the lightness is clamped between 0.0 and 1.0
  adjustedLightness = adjustedLightness.clamp(0.0, 1.0);

  // Create a new HSLColor with the adjusted lightness
  HSLColor adjustedHsl = hsl.withLightness(adjustedLightness);

  // Convert the adjusted HSLColor back to a Color
  return adjustedHsl.toColor();
}

class AppTheme {
  // Primary and secondary colors
  static const Color primaryColor = Color.fromARGB(255, 41, 119, 236);
  static const Color secondaryColor = Color(0xFF03DAC6);

  // Background and surface colors
  static const Color backgroundColor = Color(0xFFF6F6F6);
  static const Color surfaceColor = Color(0xFFFFFFFF);

  // Text colors
  static const Color primaryTextColor = Color(0xFF000000);
  static const Color secondaryTextColor = Color(0xFF757575);

  // Error color
  static const Color errorColor = Color(0xFFB00020);

  // Typography
  // static const String fontFamily =
  //     'Roboto'; // Replace with your preferred font family

  // Text styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
    // fontFamily: fontFamily,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: primaryTextColor,
    // fontFamily: fontFamily,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: secondaryTextColor,
    // fontFamily: fontFamily,
  );

  // Theme data
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: adjustBrightness(primaryColor, isDarkMode: false),
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: adjustBrightness(primaryColor, isDarkMode: false),
      secondary: adjustBrightness(secondaryColor, isDarkMode: false),
      surface: surfaceColor,
      error: errorColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: headline1,
      bodyLarge: bodyText1,
      labelLarge: caption,
    ),
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87)),
    // fontFamily: fontFamily,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: adjustBrightness(primaryColor, isDarkMode: true),
    scaffoldBackgroundColor: Color(0xFF121212),
    colorScheme: ColorScheme.dark(
      primary: adjustBrightness(primaryColor, isDarkMode: true),
      secondary: adjustBrightness(secondaryColor, isDarkMode: true),
      surface: Color(0xFF1E1E1E),
      error: errorColor,
    ),
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
    textTheme: const TextTheme(
      headlineLarge: headline1,
      bodyLarge: bodyText1,
      labelLarge: caption,
    ),
    // fontFamily: fontFamily,
  );
}
