// lib/utils/themes/custom_date_picker_theme.dart
import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class CustomDatePickerTheme {
  static final light = DatePickerThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
    ),
    headerBackgroundColor: AppColors.primaryDark,
    headerForegroundColor: Colors.white,
    headerHeadlineStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headerHelpStyle: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    weekdayStyle: const TextStyle(color: AppColors.primaryDark),
    dayStyle: const TextStyle(color: AppColors.textPrimary),
    dayForegroundColor: MaterialStateProperty.all(AppColors.textPrimary),
    dayBackgroundColor: MaterialStateProperty.all(Colors.transparent),
    dayOverlayColor: MaterialStateProperty.all(
      AppColors.primaryDark.withOpacity(0.12),
    ),
    dayShape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
    ),
    todayForegroundColor: MaterialStateProperty.all(Colors.white),
    todayBackgroundColor: MaterialStateProperty.all(AppColors.primaryDark),
    todayBorder: BorderSide(color: AppColors.primaryDark),
    yearStyle: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
    yearForegroundColor: MaterialStateProperty.all(AppColors.textPrimary),
    yearBackgroundColor: MaterialStateProperty.all(Colors.transparent),
    yearOverlayColor: MaterialStateProperty.all(
      AppColors.primaryDark.withOpacity(0.12),
    ),
    yearShape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
    ),
    rangePickerBackgroundColor: Colors.white,
    rangePickerElevation: 4,
    rangePickerShadowColor: Colors.black26,
    rangePickerSurfaceTintColor: Colors.white,
    rangePickerShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
    ),
    rangePickerHeaderBackgroundColor: AppColors.primaryDark,
    rangePickerHeaderForegroundColor: Colors.white,
    rangePickerHeaderHeadlineStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    rangePickerHeaderHelpStyle: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    rangeSelectionBackgroundColor: AppColors.primaryDark.withOpacity(0.24),
    rangeSelectionOverlayColor: WidgetStateProperty.all(
      // ignore: deprecated_member_use
      AppColors.primaryDark.withOpacity(0.12),
    ),
    dividerColor: Colors.grey.shade300,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryDark),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
    ),
    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
    ),
    locale: const Locale('tr', 'TR'),
  );

  static final dark = DatePickerThemeData(
    backgroundColor: AppColors.backgroundDark,
    elevation: 4,
    shadowColor: Colors.black54,
    surfaceTintColor: AppColors.backgroundDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
    ),
    headerBackgroundColor: AppColors.primaryLight,
    headerForegroundColor: Colors.white,
    headerHeadlineStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    headerHelpStyle: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    weekdayStyle: const TextStyle(color: AppColors.primaryLight),
    dayStyle: const TextStyle(color: AppColors.textWhite),
    dayForegroundColor: WidgetStateProperty.all(AppColors.textWhite),
    dayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    dayOverlayColor: WidgetStateProperty.all(
      AppColors.primaryLight.withOpacity(0.12),
    ),
    dayShape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
    ),
    todayForegroundColor: WidgetStateProperty.all(Colors.black),
    todayBackgroundColor: WidgetStateProperty.all(AppColors.primaryLight),
    todayBorder: BorderSide(color: AppColors.primaryLight),
    yearStyle: const TextStyle(color: AppColors.textWhite, fontSize: 14),
    yearForegroundColor: WidgetStateProperty.all(AppColors.textWhite),
    yearBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    yearOverlayColor: WidgetStateProperty.all(
      AppColors.primaryLight.withOpacity(0.12),
    ),
    yearShape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
    ),
    rangePickerBackgroundColor: AppColors.backgroundDark,
    rangePickerElevation: 4,
    rangePickerShadowColor: Colors.black54,
    rangePickerSurfaceTintColor: AppColors.backgroundDark,
    rangePickerShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
    ),
    rangePickerHeaderBackgroundColor: AppColors.primaryLight,
    rangePickerHeaderForegroundColor: Colors.white,
    rangePickerHeaderHeadlineStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    rangePickerHeaderHelpStyle: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    rangeSelectionBackgroundColor: AppColors.primaryLight.withOpacity(0.24),
    rangeSelectionOverlayColor: WidgetStateProperty.all(
      // ignore: deprecated_member_use
      AppColors.primaryLight.withOpacity(0.12),
    ),
    dividerColor: Colors.grey.shade700,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryLight),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
    ),
    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
    ),
    locale: const Locale('tr', 'TR'),
  );
}
