import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/services/theme_service.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class ThemeItem extends StatelessWidget {
  ThemeItem({super.key});
  final ThemeService themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkCard
          : AppColors.lightCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
      ),
      margin: const EdgeInsets.only(bottom: AppSizes.spacingS),
      child: ListTile(
        leading: Icon(
          Icons.brightness_6_outlined,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.textWhite
              : AppColors.primary,
        ),
        title: Text('Tema'),

        trailing: Obx(
          () => Switch(
            value: themeService.isDarkMode,
            onChanged: (value) => themeService.toogleTheme(),
          ),
        ),
      ),
    );
  }
}
