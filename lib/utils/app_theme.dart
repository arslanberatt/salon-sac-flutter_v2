import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/utils/themes/app_bar_theme.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/themes/dropdown_theme.dart';
import 'package:salon_sac_flutter_v2/utils/themes/elevated_button_theme.dart';
import 'package:salon_sac_flutter_v2/utils/themes/text_field_theme.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Archivo',
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: CustomAppbarThemes.lightAppBarTheme.copyWith(
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: CustomTextFieldTheme.lightTextFieldTheme,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.textWhite),
      trackColor: MaterialStateProperty.all(AppColors.inputBorder),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),
    cardColor: AppColors.textWhite,
    dropdownMenuTheme: DropdownTheme.light,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Archivo',
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: CustomAppbarThemes.darkAppBarTheme.copyWith(
      iconTheme: const IconThemeData(color: AppColors.textWhite),
    ),
    iconTheme: const IconThemeData(color: AppColors.textWhite),
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: CustomTextFieldTheme.darkTextFieldTheme,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.textWhite),
      trackColor: MaterialStateProperty.all(
        AppColors.textPrimary.withOpacity(0.4),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textWhite),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),
    cardColor: const Color.fromRGBO(27, 54, 77, 1),
    dropdownMenuTheme: DropdownTheme.dark,
  );
}
