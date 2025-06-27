import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';

class AdminController extends BaseController {
  final currentIndex = 0.obs;
  changePage(int index) {
    currentIndex.value = index;
  }

  cikisYap() async {
    await Get.find<AuthService>().signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  // void goToTransaction() {
  //   Get.toNamed(AppRoutes.TRANSACTION);
  // }
}
