import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Callback onTap;
  const SettingsItem({
    required this.icon,
    required this.title,
    super.key,
    required this.onTap,
  });

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
          icon,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.textWhite
              : AppColors.primary,
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}