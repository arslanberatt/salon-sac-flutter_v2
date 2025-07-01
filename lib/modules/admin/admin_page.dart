import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_controller.dart';
import 'package:salon_sac_flutter_v2/modules/admin_dashboard/admin_dashboard_page.dart';
import 'package:salon_sac_flutter_v2/modules/calendar/calendar_page.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_page.dart';

import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_page.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class AdminPage extends GetView<AdminController> {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [
            AdminDashboardPage(),
            CalendarPage(),
            TransactionDashboardPage(),
            SettingPage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToSetting,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 32, color: AppColors.backgroundLight),
        backgroundColor: AppColors.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          icons: [
            Icons.dashboard_outlined,
            Icons.calendar_today_outlined,
            Icons.account_balance_wallet_outlined,
            Icons.settings_outlined,
          ],
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
