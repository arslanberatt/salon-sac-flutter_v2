import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_controller.dart';
import 'package:salon_sac_flutter_v2/modules/admin_dashboard/admin_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employe_list/employee_list_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employee_managment/employee_management_controller.dart';
import 'package:salon_sac_flutter_v2/modules/profile/profile_controller.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/update_service_controller.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_controller.dart';
import 'package:salon_sac_flutter_v2/modules/support/support_controller.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/controllers/transaction_controller.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_controller.dart';

class AdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
    Get.lazyPut<AdminDashboardController>(() => AdminDashboardController());
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
      fenix: true,
    );
    Get.lazyPut<TransactionDashboardController>(
      () => TransactionDashboardController(),
    );
    Get.lazyPut<SettingController>(() => SettingController());

    Get.lazyPut<UpdateServiceController>(
      () => UpdateServiceController(),
      fenix: true,
    );
    Get.lazyPut<SupportController>(() => SupportController(), fenix: true);
    Get.lazyPut<EmployeeListController>(
      () => EmployeeListController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ServiceController>(() => ServiceController(), fenix: true);
    Get.lazyPut<EmployeeManagementController>(
      () => EmployeeManagementController(),
      fenix: true,
    );
    Get.lazyPut<AppointmentController>(
      () => AppointmentController(),
      fenix: true,
    );
  }
}
