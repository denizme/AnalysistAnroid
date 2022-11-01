import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color,
    [double height = 1.2, double letterSpacing = 0.7]) {
  return GoogleFonts.roboto(
      height: height,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing);
}

// regular style

TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  required Color color,
  double height = 1.2,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily,
      FontWeightManager.regular, color, height);
}
// light text style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
}
// bold text style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeight.w600, color);
}

// semi bold text style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color);
}

// medium text style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double letterSpacing = 1.2}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily,
      FontWeightManager.medium, color, 1.2, letterSpacing);
}
