import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';

class EmployeeController extends BaseController {
  final currentIndex = 0.obs;
  changePage(int index) {
    currentIndex.value = index;
  }

  cikisYap() async {
    await Get.find<AuthService>().signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  void goToAppointment() {
    Get.toNamed(AppRoutes.APPOINTMENT);
  }

  void goToCalendar() {
    Get.toNamed(AppRoutes.CALENDAR);
  }

  // void goToAppointment() {
  //   Get.toNamed(AppRoutes.APPOINTMENT);
  // }
}
