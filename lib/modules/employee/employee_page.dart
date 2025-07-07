import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/employee_dashboard_page.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_page.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class EmployeePage extends GetView<EmployeeController> {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [EmployeeDashboardPage(), SettingPage()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToAppointment,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 32, color: AppColors.backgroundLight),
        backgroundColor: AppColors.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          icons: [Icons.dashboard_outlined, Icons.settings_outlined],
          activeIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          gapLocation: GapLocation.center,
          splashColor: AppColors.backgroundLight,
          activeColor: AppColors.backgroundLight,
          inactiveColor: AppColors.textSecondary,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 36,
          rightCornerRadius: 36,
          backgroundColor: AppColors.primaryDark,
        ),
      ),
    );
  }
}
