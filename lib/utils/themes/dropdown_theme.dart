import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class DropdownTheme {
  static final light = DropdownMenuThemeData(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
    menuStyle: MenuStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.textWhite),
      elevation: MaterialStatePropertyAll(2),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  static final dark = DropdownMenuThemeData(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textWhite,
    ),
    menuStyle: MenuStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.primary),
      elevation: MaterialStatePropertyAll(2),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
