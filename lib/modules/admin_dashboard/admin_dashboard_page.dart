import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/admin_dashboard/admin_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/admin_dashboard/widgets/transaction_container.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/today_appointments.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/custom_appbar.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/section_title.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AdminDashboardPage extends GetView<AdminDashboardController> {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TransactionContainer(),
            const SizedBox(height: AppSizes.spacingXL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SectionTitle(
                  title: "Kategoriler",
                  subtitle: "Günlük planlar ve randevular",
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _categoryCard(
                    context,
                    Icon(Icons.people_alt_outlined),
                    "Çalışanlar",
                    controller.goTogoToEmployeeList,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _categoryCard(
                    context,
                    Icon(Icons.cut_outlined),

                    "Hizmetler",
                    controller.goToService,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Ongoing Plan
            SectionTitle(title: "Randevular", subtitle: "Bugün ki randevular"),
            TodaysAppointmentsList(),
          ],
        ),
      ),
    );
  }
}

Widget _categoryCard(
  BuildContext context,
  Icon icon,
  String title,
  Callback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
      ),
      child: Column(
        children: [
          icon,
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 4),
        ],
      ),
    ),
  );
}
