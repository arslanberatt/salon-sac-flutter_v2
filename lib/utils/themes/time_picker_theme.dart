// lib/utils/themes/custom_time_picker_theme.dart
import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class CustomTimePickerTheme {
  static final light = TimePickerThemeData(
    // Genel
    backgroundColor: Colors.white,
    dialBackgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
    ),
    padding: const EdgeInsets.all(16),

    // İptal / Onay butonları
    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
    ),

    // Saat-dakika seçici
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
    ),
    hourMinuteColor: AppColors.primaryLight.withOpacity(0.12),
    hourMinuteTextColor: AppColors.primaryLight,
    hourMinuteTextStyle: const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),

    // Gün dönemi (AM/PM)
    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
    ),
    dayPeriodBorderSide: BorderSide(color: AppColors.primaryDark),
    dayPeriodColor: AppColors.primaryDark.withOpacity(0.12),
    dayPeriodTextColor: AppColors.primaryDark,
    dayPeriodTextStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.textSecondary,
    ),

    // Çark (dial)
    dialHandColor: AppColors.textSecondary,
    dialTextColor: AppColors.textPrimary,
    dialTextStyle: const TextStyle(fontSize: 14, color: AppColors.textPrimary),

    // Giriş modu ikonu & yardım metni
    entryModeIconColor: AppColors.primaryDark,
    helpTextStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.textSecondary,
    ),

    // TextField stili
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryDark),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
    ),

    // Ayırıcı çizgi stili
    timeSelectorSeparatorColor: MaterialStateProperty.all(
      AppColors.primaryLight,
    ),
    timeSelectorSeparatorTextStyle: MaterialStateProperty.all(
      const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  static final dark = TimePickerThemeData(
    backgroundColor: AppColors.backgroundDark,
    dialBackgroundColor: AppColors.backgroundDark,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
    ),
    padding: const EdgeInsets.all(16),

    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
    ),

    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
    ),
    hourMinuteColor: AppColors.primaryLight.withOpacity(0.12),
    hourMinuteTextColor: AppColors.textWhite,
    hourMinuteTextStyle: const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: AppColors.textWhite,
    ),

    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
    ),
    dayPeriodBorderSide: BorderSide(color: AppColors.primaryLight),
    dayPeriodColor: AppColors.primaryLight.withOpacity(0.12),
    dayPeriodTextColor: AppColors.primaryLight,
    dayPeriodTextStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.textWhite,
    ),

    dialHandColor: AppColors.primaryLight,
    dialTextColor: AppColors.textWhite,
    dialTextStyle: const TextStyle(fontSize: 14, color: AppColors.textWhite),

    entryModeIconColor: AppColors.primaryLight,
    helpTextStyle: const TextStyle(fontSize: 14, color: AppColors.textWhite),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryLight),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
    ),

    timeSelectorSeparatorColor: MaterialStateProperty.all(
      AppColors.primaryLight,
    ),
    timeSelectorSeparatorTextStyle: MaterialStateProperty.all(
      const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
