import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';
import 'package:salon_sac_flutter_v2/services/storage_service.dart';

class SplashController extends BaseController {
  @override
  void onReady() async {
    super.onReady();
    await waitForServices();
    await checkTokenAndRedirect();
  }

  Future<void> waitForServices() async {
    while (!Get.isRegistered<StorageService>() ||
        !Get.isRegistered<ApiServices>() ||
        !Get.isRegistered<AuthService>()) {
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<void> checkTokenAndRedirect() async {
    final authService = Get.find<AuthService>();
    final isAuth = await authService.isAuthenticated();
    if (isAuth) {
      final user = authService.currentUser.value;
      if (user?.isAdmin == true) {
        Get.offAllNamed(AppRoutes.ADMIN);
      } else {
        Get.offAllNamed(AppRoutes.EMPLOYEE);
      }
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
