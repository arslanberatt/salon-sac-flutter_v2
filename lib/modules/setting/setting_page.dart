import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_controller.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';
import 'package:salon_sac_flutter_v2/services/theme_service.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.grey.shade300,
                      child: controller.user.value?.avatar != null
                          ? ClipOval(
                              child: Image.network(
                                '${ApiConstants.baseUrl}${controller.user.value!.avatar}',
                                width: 96,
                                height: 96,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.person, size: 48),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileTitle(
                          title:
                              '${controller.user.value?.name ?? ''} ${controller.user.value?.lastname ?? ''}',
                          subtitle: controller.user.value?.email ?? '',
                          phone: controller.user.value?.phone ?? '',
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    controller.logout();
                  },
                ),
              ],
            ),
          ),
          const SectionTitle(title: "Hesap", subtitle: "Hesap güncellemeleri"),
          const SettingsItem(
            icon: Icons.person_outline,
            title: "Hesap Bilgileri",
          ),
          const SizedBox(height: AppSizes.spacingL),
          const SectionTitle(
            title: "Uygulama",
            subtitle: "Kullanım ve gizlilik",
          ),
          ThemeItem(),
          const SettingsItem(icon: Icons.lock_outline, title: "Şifre"),
          const SettingsItem(
            icon: Icons.support_agent_outlined,
            title: "İletişim",
          ),
          const SettingsItem(
            icon: Icons.privacy_tip_outlined,
            title: "Gizlilik",
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
        child: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      centerTitle: false,
      actionsPadding: EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}

class ProfileTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String phone;
  const ProfileTitle({
    required this.title,
    required this.subtitle,
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.spacingM),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          Text(
            phone,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionTitle({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const SettingsItem({required this.icon, required this.title, super.key});

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
        onTap: () {},
      ),
    );
  }
}

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
