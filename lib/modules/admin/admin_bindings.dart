import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_controller.dart';
import 'package:salon_sac_flutter_v2/modules/admin_dashboard/admin_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/update_service_controller.dart';
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
    Get.lazyPut<ServiceController>(() => ServiceController(), fenix: true);
    Get.lazyPut<UpdateServiceController>(
      () => UpdateServiceController(),
      fenix: true,
    );
  }
}
