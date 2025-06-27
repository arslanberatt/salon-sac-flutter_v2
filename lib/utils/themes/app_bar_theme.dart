import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class CustomAppbarThemes {
  // Light Theme AppBar
  static const lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.primary,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shadowColor: Colors.transparent,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.textWhite, size: 24),
    actionsIconTheme: IconThemeData(color: AppColors.textWhite, size: 24),
    titleTextStyle: TextStyle(
      color: AppColors.textWhite,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.primaryLight,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shadowColor: Colors.transparent,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.textWhite, size: 24),
    actionsIconTheme: IconThemeData(color: AppColors.textWhite, size: 24),
    titleTextStyle: TextStyle(
      color: AppColors.textWhite,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
  );
}
