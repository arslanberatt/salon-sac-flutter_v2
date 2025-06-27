import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class CustomTextFieldTheme {
  CustomTextFieldTheme._();

  static final lightTextFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.inputFill,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
      borderSide: const BorderSide(color: AppColors.accent, width: 1.8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    labelStyle: const TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: const TextStyle(
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w400,
    ),
  );

  static final darkTextFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.backgroundDark,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      borderSide: const BorderSide(color: AppColors.accent, width: 1.8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    labelStyle: const TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: const TextStyle(
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w400,
    ),
  );
}
