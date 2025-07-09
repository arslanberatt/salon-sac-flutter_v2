import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class EmployeeDashboardController extends BaseController {
  void goToService() {
    Get.toNamed(AppRoutes.SERVICE);
  }

  void goToSalaryRecords() {
    Get.toNamed(AppRoutes.SALARY);
  }

  void goToCalendar() {
    Get.toNamed(AppRoutes.CALENDAR);
  }

  void goToAdvanceRequest() {
    Get.toNamed(AppRoutes.ADVANCEREQUEST);
  }
}
