import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen/utils/responsive_sizer.dart';

final _textStyle = GoogleFonts.poppins();
ThemeData themeData = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    displayLarge: _textStyle.copyWith(
      fontSize: 72.sf,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: _textStyle.copyWith(
      fontSize: 30.sf,
      fontStyle: FontStyle.italic,
    ),
    bodyMedium: _textStyle.copyWith(
      fontSize: 16.sf,
    ),
    displaySmall: _textStyle.copyWith(
      fontSize: 12.sf,
    ),
  ),
);
