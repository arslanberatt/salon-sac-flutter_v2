// lib/utils/themes/custom_dialog_theme.dart
import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class CustomDialogTheme {
  static final light = DialogThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
    ),
    titleTextStyle: const TextStyle(
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: const TextStyle(
      color: AppColors.textSecondary,
      fontSize: 14,
    ),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static final dark = DialogThemeData(
    backgroundColor: AppColors.backgroundDark,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
    ),
    titleTextStyle: const TextStyle(
      color: AppColors.textWhite,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: const TextStyle(
      color: AppColors.textWhite,
      fontSize: 14,
    ),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );
}
