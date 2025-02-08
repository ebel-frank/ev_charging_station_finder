import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/assets.dart';

class SettingsService extends GetxService {

  final String appName = "EV-Stations";
  final String defaultCountryCode = "+234";

  Future<SettingsService> init() async {
    return this;
  }

  ThemeData getTheme() {
    return ThemeData(
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: Assets.accentColor.withOpacity(0.1),
        dividerTheme: DividerThemeData(
          color: Assets.accentColor.withOpacity(0.1)
        ),
        focusColor: Assets.accentColor,
        hintColor: CupertinoColors.systemGrey,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Assets.primaryColor,
        )),
        colorScheme: ColorScheme.light(
          primary: Assets.primaryColor,
          secondary: Assets.primaryColor,
        ),
        textTheme: GoogleFonts.getTextTheme('Manrope',
          TextTheme(
            // titleLarge: TextStyle(
            //     fontSize: 15.0,
            //     fontWeight: FontWeight.w700,
            //     color: Ui.parseColor(setting.value.mainColor),
            //     height: 1.3),
            // headlineSmall: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.w700,
            //     color: Ui.parseColor(setting.value.secondColor),
            //     height: 1.3),
            // headlineMedium: TextStyle(
            //     fontSize: 18.0,
            //     fontWeight: FontWeight.w400,
            //     color: Ui.parseColor(setting.value.secondColor),
            //     height: 1.3),
            // displaySmall: TextStyle(
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.w700,
            //     color: Ui.parseColor(setting.value.secondColor),
            //     height: 1.3),
            // displayMedium: TextStyle(
            //     fontSize: 22.0,
            //     fontWeight: FontWeight.w700,
            //     color: Ui.parseColor(setting.value.mainColor),
            //     height: 1.4),
            // displayLarge: TextStyle(
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.w300,
            //     color: Ui.parseColor(setting.value.secondColor),
            //     height: 1.4),
            // titleSmall: TextStyle(
            //     fontSize: 15.0,
            //     fontWeight: FontWeight.w600,
            //     color: Ui.parseColor(setting.value.secondColor),
            //     height: 1.2),
            // titleMedium: TextStyle(
            //     fontSize: 13.0,
            //     fontWeight: FontWeight.w400,
            //     color: Ui.parseColor(setting.value.mainColor),
            //     height: 1.2),
            // bodyMedium: TextStyle(
            //     fontSize: 13.0,
            //     fontWeight: FontWeight.w600,
            //     color: Ui.parseColor(setting.value.secondColor),
            //     height: 1.2),
            // bodyLarge: TextStyle(
            //     fontSize: 12.0,
            //     fontWeight: FontWeight.w400,
            //     color: Ui.parseColor(setting.value.secondColor),
            //     height: 1.2),
            bodySmall: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                color: Colors.black45,
                height: 1.2),
          ),
        ));
  }

}