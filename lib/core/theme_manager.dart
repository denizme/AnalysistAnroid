import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/core/values_manager.dart';

import 'colors.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  Map<int, Color> color = {
    50: Color.fromRGBO(255, 18, 111, .1),
    100: Color.fromRGBO(255, 18, 111, .2),
    200: Color.fromRGBO(255, 18, 111, .3),
    300: Color.fromRGBO(255, 18, 111, .4),
    400: Color.fromRGBO(255, 18, 111, .5),
    500: Color.fromRGBO(255, 18, 111, .6),
    600: Color.fromRGBO(255, 18, 111, .7),
    700: Color.fromRGBO(255, 18, 111, .8),
    800: Color.fromRGBO(255, 18, 111, .9),
    900: Color.fromRGBO(255, 18, 111, 1),
  };
  MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.backgroundColor,
      primarySwatch: colorCustom,
      disabledColor: ColorManager
          .grey1, // will be used incase of disabled button for example
      accentColor: ColorManager.grey,
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.backgroundColor,
          titleTextStyle:
              getBoldStyle(color: ColorManager.white, fontSize: FontSize.s20)),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              primary: ColorManager.primary,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10)))),
      // Text theme
      textTheme: GoogleFonts.poppinsTextTheme(),
      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.grey1),

        // label style
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.transparent, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.transparent, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
