import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/section_title.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_controller.dart';
import 'package:salon_sac_flutter_v2/modules/profile/profile_controller.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_controller.dart';
import 'package:salon_sac_flutter_v2/modules/setting/widgets/profile_item.dart';
import 'package:salon_sac_flutter_v2/modules/setting/widgets/setting_item.dart';
import 'package:salon_sac_flutter_v2/modules/setting/widgets/theme_item.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            onPressed: () => Get.find<EmployeeController>().goToAppointment(),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Obx(
        () => ListView(
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
                        child: controller.user.value?.avatar?.isNotEmpty == true
                            ? ClipOval(
                                child: Image.network(
                                  '${ApiConstants.baseUrl}${controller.user.value!.avatar}',
                                  width: 96,
                                  height: 96,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.person,
                                    size: 64,
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            : const Icon(Icons.person, size: 48),
                      ),
                      const SizedBox(width: 16),
                      ProfileItem(
                        title:
                            '${controller.user.value?.name ?? ''} ${controller.user.value?.lastname ?? ''}',
                        subtitle: controller.user.value?.email ?? '',
                        phone: controller.user.value?.phone ?? '',
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
            const SectionTitle(
              title: "Hesap",
              subtitle: "Hesap güncellemeleri",
            ),
            SettingsItem(
              icon: Icons.person_outline,
              title: "Hesap Bilgileri",
              onTap: () => Get.find<ProfileController>().goToProfile(),
            ),
            const SizedBox(height: AppSizes.spacingL),
            const SectionTitle(
              title: "Uygulama",
              subtitle: "Kullanım ve gizlilik",
            ),
            ThemeItem(),
            SettingsItem(
              icon: Icons.lock_outline,
              title: "Şifre",
              onTap: () => Get.find<ProfileController>().goToChangePassword(),
            ),
            SettingsItem(
              icon: Icons.support_agent_outlined,
              title: "İletişim",
              onTap: () => Get.find<SettingController>().goToSupport(),
            ),
            SettingsItem(
              icon: Icons.privacy_tip_outlined,
              title: "Gizlilik",
              onTap: () => Get.find<SettingController>().goToPrivacy(),
            ),
          ],
        ),
      ),
    );
  }
}
