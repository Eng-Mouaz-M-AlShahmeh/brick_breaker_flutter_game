/* Developed by Eng Mouaz M AlShahmeh */
import 'package:flutter/material.dart';
import 'colors.dart';

extension CustomColorSchemeX on ColorScheme {
  Color get primaryMainColor => brightness == Brightness.light
      ? AppColors.blueColor
      : AppColors.brownColor;

  Color get bubbleBackgroundColor => brightness == Brightness.light
      ? AppColors.whiteColor
      : AppColors.blackColor;

  Color get gameColor => brightness == Brightness.light
      ? AppColors.blueColor
      : AppColors.beigeColor;

  Color get firstBrickColor =>
      brightness == Brightness.light ? AppColors.blueColor : AppColors.greenColor;

  Color get secondBrickColor => brightness == Brightness.light
      ? AppColors.redColor
      : AppColors.beigeColor;

  Color get thirdBrickColor => brightness == Brightness.light
      ? AppColors.greenLightColor
      : AppColors.redColor;

  Color get firstBrickLightColor => brightness == Brightness.light
      ? AppColors.blueLightColor
      : AppColors.greenLightColor;

  Color get secondBrickLightColor => brightness == Brightness.light
      ? AppColors.redColorLight
      : AppColors.beigeLightColor;

  Color get thirdBrickLightColor => brightness == Brightness.light
      ? AppColors.greenColor
      : AppColors.redColorLight;
}
