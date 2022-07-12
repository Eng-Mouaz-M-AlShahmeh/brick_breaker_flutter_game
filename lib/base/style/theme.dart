/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/utils/asset_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.blueColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: AppColors.blueColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: AppColors.blueColor,
      )),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.whiteColor,
            // Status bar brightness
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.blueColor,
          centerTitle: true),
      textTheme: const TextTheme(
        bodyText1: TextStyle(fontFamily: AssetResource.appFontName),
        bodyText2: TextStyle(fontFamily: AssetResource.appFontName),
        subtitle1: TextStyle(fontFamily: AssetResource.appFontName),
        subtitle2: TextStyle(fontFamily: AssetResource.appFontName),
        headline4: TextStyle(
            fontFamily: AssetResource.appFontName,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        headline5: TextStyle(fontFamily: AssetResource.appFontName),
        headline6: TextStyle(fontFamily: AssetResource.appFontName),
        button: TextStyle(fontFamily: AssetResource.appFontName, fontSize: 20),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.brownColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: AppColors.brownColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: AppColors.brownColor,
      )),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.blackColor,
            // Status bar brightness
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          foregroundColor: AppColors.brownColor,
          centerTitle: true),
      textTheme: const TextTheme(
        bodyText1: TextStyle(fontFamily: AssetResource.appFontName),
        bodyText2: TextStyle(fontFamily: AssetResource.appFontName),
        subtitle1: TextStyle(fontFamily: AssetResource.appFontName),
        subtitle2: TextStyle(fontFamily: AssetResource.appFontName),
        headline4: TextStyle(
            fontFamily: AssetResource.appFontName,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        headline5: TextStyle(fontFamily: AssetResource.appFontName),
        headline6: TextStyle(fontFamily: AssetResource.appFontName),
        button: TextStyle(fontFamily: AssetResource.appFontName, fontSize: 20),
      ),
    );
  }
}
