import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class CustomAppbarThemes {
  static final lightAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontFamily: 'Archivo',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  static final darkAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontFamily: 'Archivo',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textWhite,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
