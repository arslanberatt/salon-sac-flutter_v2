import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_controller.dart';
import 'package:salon_sac_flutter_v2/modules/admin_dashboard/admin_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_controller.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/transaction_controller.dart';

class AdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<AdminDashboardController>(() => AdminDashboardController());
    Get.lazyPut<TransactionController>(() => TransactionController());
  }
}
