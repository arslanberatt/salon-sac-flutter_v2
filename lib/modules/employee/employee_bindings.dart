import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/advance_request/advance_request_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/controllers/balance_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/employee_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/salary/salary_controller.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_controller.dart';

class EmployeeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<EmployeeDashboardController>(
      () => EmployeeDashboardController(),
    );
    Get.lazyPut<AdvanceRequestController>(
      () => AdvanceRequestController(),
      fenix: true,
    );
    Get.lazyPut<SalaryController>(() => SalaryController(), fenix: true);
    Get.lazyPut<BalanceController>(() => BalanceController(), fenix: true);
  }
}
