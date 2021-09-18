import 'package:flutter/material.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class AppThemes {
  factory AppThemes() {
    return _instance;
  }

  // 内部から呼び出してインスタンスを作る為のコンストラクタ
  AppThemes._internal();

  // インスタンスのキャッシュ
  static final AppThemes _instance = AppThemes._internal();

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      primaryColor: AppColors.primary,
      primaryColorBrightness: Brightness.light,
      textTheme: _lightTextTheme,
      appBarTheme: const AppBarTheme(
        color: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.black),
        titleTextStyle: TextStyle(
          color: AppColors.textLightPrimary,
        ),
      ),
      backgroundColor: AppColors().grey,
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primary,
      primaryColorBrightness: Brightness.dark,
      textTheme: _darkTextTheme,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(
          color: AppColors.textDarkPrimary,
        ),
      ),
      backgroundColor: AppColors().grey,
    );
  }

  final _lightTextTheme = const TextTheme(
    headline1: TextStyle(color: AppColors.textLightSecondary),
    headline2: TextStyle(color: AppColors.textLightSecondary),
    headline3: TextStyle(color: AppColors.textLightSecondary),
    headline4: TextStyle(color: AppColors.textLightSecondary),
    headline5: TextStyle(color: AppColors.textLightSecondary),
    headline6: TextStyle(color: AppColors.textLightPrimary),
    subtitle1: TextStyle(color: AppColors.textLightPrimary),
    subtitle2: TextStyle(color: AppColors.textLightPrimary),
    bodyText1: TextStyle(color: AppColors.textLightPrimary),
    bodyText2: TextStyle(color: AppColors.textLightSecondary),
    caption: TextStyle(color: AppColors.textLightSecondary),
    button: TextStyle(color: AppColors.textLightPrimary),
    overline: TextStyle(color: AppColors.textLightSecondary),
  );

  final _darkTextTheme = const TextTheme(
    headline1: TextStyle(color: AppColors.textLightSecondary),
    headline2: TextStyle(color: AppColors.textLightSecondary),
    headline3: TextStyle(color: AppColors.textLightSecondary),
    headline4: TextStyle(color: AppColors.textLightSecondary),
    headline5: TextStyle(color: AppColors.textLightSecondary),
    headline6: TextStyle(color: AppColors.textLightPrimary),
    subtitle1: TextStyle(color: AppColors.textLightPrimary),
    subtitle2: TextStyle(color: AppColors.textLightPrimary),
    bodyText1: TextStyle(color: AppColors.textLightPrimary),
    bodyText2: TextStyle(color: AppColors.textLightSecondary),
    caption: TextStyle(color: AppColors.textLightSecondary),
    button: TextStyle(color: AppColors.textLightPrimary),
    overline: TextStyle(color: AppColors.textLightSecondary),
  );
}
