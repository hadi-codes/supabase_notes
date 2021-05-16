import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color yellow = const Color(0xffF59E0B);
  static Color red = const Color(0xffEF4444);
  static Color purple = const Color(0xff8B5CF6);
  static Color pink = const Color(0xffEC4899);
  static Color indigo = const Color(0xff6366F1);
  static Color green = const Color(0xff10B981);
  static Color gray1 = const Color(0xff1f1f1f);

  static Color gray2 = const Color(0xff181818);
  static Color blue = const Color(0xff3B82F6);
  static Color white = Colors.white;
  static final ThemeData themeData = ThemeData(
      primaryColor: gray2,
      accentColor: green,
      scaffoldBackgroundColor: gray1,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(backgroundColor: green, primary: white)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: green, foregroundColor: white),
      brightness: Brightness.dark,
      //  accentIconTheme: IconThemeData(color: Colors.white),
      textTheme: textTheme);
  static final textTheme = TextTheme(
    headline1: GoogleFonts.roboto(
        fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.roboto(
        fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.roboto(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.roboto(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.roboto(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.roboto(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
}
