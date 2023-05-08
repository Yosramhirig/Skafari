import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.sourceSerifPro(
    fontSize: 32,
    color: Colors.black87,
    fontWeight: FontWeight.bold,

  ),
  displayMedium: GoogleFonts.sourceSerifPro(
    fontSize: 20,
    color: Colors.black87,
    fontWeight: FontWeight.w800,
  ),
  displaySmall: GoogleFonts.sourceSerifPro(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black87,
    fontWeight: FontWeight.w400,
  ),
  headlineSmall: GoogleFonts.poppins(
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  ),
);

class AppColors {
  static Color darkblue = const Color(0xff026E81);
  static Color lightblue = const Color(0xff00ABBD);
  static Color skyblue = const Color(0xff0099DD);
  static Color orange = const Color(0xffFF9933);
  static Color whiteblue = const Color(0xffA1C7E0);
  static Color black = Colors.black87;
  static Color white = Colors.white;

}

List<Color> boxColors = const [
  Color(0xffCEEDEF),
  Color(0xffBFBFBF),
  Color(0xffEBECF1),
  Color(0xffFDF7DD),
  Color(0xffF9CFE3),
  Color(0xffFBEBC7),
  Color(0xffE9E8E6)
];
