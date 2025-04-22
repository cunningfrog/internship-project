import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color accentColor = Color(0xFF4D44BD);
  static const Color backgroundColor = Color(0xFFF8F8FF);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF212121);
  static const Color secondaryTextColor = Color(0xFF757575);
  static const Color errorColor = Color(0xFFEF5350);
  static const Color successColor = Color(0xFF66BB6A);
  static const Color dividerColor = Color(0xFFE0E0E0);

  // Text styles
  static final TextStyle headingStyle = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static final TextStyle subheadingStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static final TextStyle bodyStyle = GoogleFonts.poppins(
    fontSize: 16,
    color: textColor,
  );

  static final TextStyle captionStyle = GoogleFonts.poppins(
    fontSize: 14,
    color: secondaryTextColor,
  );

  // Button styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );

  static final ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor),
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // Input decoration
  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: captionStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  // App theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: textColor),
      titleTextStyle: headingStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: primaryButtonStyle,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: secondaryButtonStyle,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: headingStyle,
      titleLarge: subheadingStyle,
      bodyLarge: bodyStyle,
      bodyMedium: captionStyle,
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.white;
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}
