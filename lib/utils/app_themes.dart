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
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.black),
        backwardsCompatibility: false,
        titleTextStyle: TextStyle(
          color: AppColors.textLightPrimary,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.white,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textLightSecondary.withOpacity(0.7),
        indicator: const ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.primary, width: 2, style: BorderStyle.solid),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primary,
      primaryColorBrightness: Brightness.dark,
      textTheme: _darkTextTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        iconTheme: IconThemeData(color: AppColors.white),
        backwardsCompatibility: false,
        titleTextStyle: TextStyle(
          color: AppColors.textDarkPrimary,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.black,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textDarkSecondary.withOpacity(0.7),
        indicator: const ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.primary, width: 2, style: BorderStyle.solid),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
      ),
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
    headline1: TextStyle(color: AppColors.textDarkSecondary),
    headline2: TextStyle(color: AppColors.textDarkSecondary),
    headline3: TextStyle(color: AppColors.textDarkSecondary),
    headline4: TextStyle(color: AppColors.textDarkSecondary),
    headline5: TextStyle(color: AppColors.textDarkSecondary),
    headline6: TextStyle(color: AppColors.textDarkPrimary),
    subtitle1: TextStyle(color: AppColors.textDarkPrimary),
    subtitle2: TextStyle(color: AppColors.textDarkPrimary),
    bodyText1: TextStyle(color: AppColors.textDarkPrimary),
    bodyText2: TextStyle(color: AppColors.textDarkSecondary),
    caption: TextStyle(color: AppColors.textDarkSecondary),
    button: TextStyle(color: AppColors.textDarkPrimary),
    overline: TextStyle(color: AppColors.textDarkSecondary),
  );
}
