import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/employee_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_controller.dart';

class EmployeeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<EmployeeDashboardController>(
      () => EmployeeDashboardController(),
    );
  }
}
