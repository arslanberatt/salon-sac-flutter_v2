import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/modules/profile/profile_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class PersonalInfoCard extends GetView<ProfileController> {
  const PersonalInfoCard({super.key});

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingXS),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryDark),
          const SizedBox(width: AppSizes.paddingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value!;

    final createdAt = user.createdAt != null
        ? DateFormat('dd MMM yyyy', 'tr_TR').format(user.createdAt!)
        : '-';

    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hesap Bilgileri",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const Divider(height: AppSizes.paddingM * 2),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow(
                      Icons.person_outline,
                      "Adı Soyadı",
                      '${user.name!} ${user.lastname!}',
                    ),
                    _infoRow(
                      Icons.calendar_today_outlined,
                      "Kayıt Tarihi",
                      createdAt,
                    ),
                    _infoRow(Icons.email_outlined, "Email Adresi", user.email!),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow(
                      Icons.verified_user_outlined,
                      "Rol",
                      user.isAdmin! ? "Admin" : "Çalışan",
                    ),
                    _infoRow(
                      Icons.work_outline,
                      "Prim Oranı",
                      "${user.commissionRate}%",
                    ),
                    _infoRow(
                      Icons.phone_outlined,
                      "Telefon Numarası",
                      user.phone!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
