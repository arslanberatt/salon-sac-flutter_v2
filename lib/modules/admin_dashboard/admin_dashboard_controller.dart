import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class AdminDashboardController extends BaseController {
  void goToService() {
    Get.toNamed(AppRoutes.SERVICE);
  }
  
  void goTogoToEmployeeList() {
    Get.toNamed(AppRoutes.EMPLOYEELIST);
  }
}
