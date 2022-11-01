import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#000000");
  static Color secondary = HexColor.fromHex("#ffffff");
  static Color accentColor = HexColor.fromHex("#B673F3");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color backgroundColor = HexColor.fromHex("#ffffff");
  static Color bottomBarColor = HexColor.fromHex("#252836");
  static Color lightWhite = Colors.white70;
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color loadingColor = Color.fromRGBO(220, 220, 220, 1);
  static Color error = HexColor.fromHex("#e61f34");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
