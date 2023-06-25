import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff13132A),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontFamily: GoogleFonts.openSans().fontFamily,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: Colors.white38,
        fontSize: 16,
        fontFamily: GoogleFonts.openSans().fontFamily,
        fontWeight: FontWeight.normal,
      ),
    ));
