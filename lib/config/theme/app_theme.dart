import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSeed = Color(0xFFDCAB73);
// const scaffoldBackgroundColor = Color.fromARGB(255, 255, 255, 255);

class AppTheme {
  ThemeData themeData() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: colorSeed,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins()
              .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
          titleMedium: GoogleFonts.poppins()
              .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
          titleSmall: GoogleFonts.poppins().copyWith(fontSize: 20),
          bodyLarge: GoogleFonts.poppins().copyWith(fontSize: 18),
          bodyMedium: GoogleFonts.poppins().copyWith(fontSize: 16),
          bodySmall: GoogleFonts.poppins().copyWith(fontSize: 14),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        // scaffoldBackgroundColor: scaffoldBackgroundColor,
      );
}
