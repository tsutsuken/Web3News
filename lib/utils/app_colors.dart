import 'package:flutter/material.dart';

class AppColors {
  factory AppColors() {
    return _;
  }

  AppColors._internal();
  static final AppColors _ = AppColors._internal();

  static const Color primary = Color(0xFF0079D1);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFE4E7E7);
  static const Color brightGrey = Color(0xFF9AA7A6);
  static const Color black = Color(0xFF1A1C1E);

  static const Color textLightPrimary = Color(0xFF1A1C1E);
  static const Color textLightSecondary = Color(0xFF404A49);
  static const Color textLightDisabled = Color(0xFFA7AEB4);
  static const Color textDarkPrimary = Color(0xFFFEFEFE);
  static const Color textDarkSecondary = Color(0xFFE4E7E7);
  static const Color textDarkDisabled = Color(0x61FEFEFE);

  bool get isDarkTheme =>
      WidgetsBinding.instance?.window.platformBrightness == Brightness.dark;

  Color get grey {
    return isDarkTheme ? lightGrey : brightGrey;
  }

  Color get primaryText {
    return isDarkTheme ? textDarkPrimary : textLightPrimary;
  }
}
