import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/today_appointments.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/section_title.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/employee_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/widgets/salaryCard.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class EmployeeDashboardPage extends GetView<EmployeeDashboardController> {
  const EmployeeDashboardPage({super.key});

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
            onPressed: () =>
                Get.find<EmployeeDashboardController>().goToSalaryRecords(),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SalaryCard(),
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
                    Icon(Icons.list),
                    "Takvim",
                    controller.goToCalendar,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _categoryCard(
                    context,
                    Icon(Icons.request_page_outlined),
                    "Avans",
                    controller.goToAdvanceRequest,
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
