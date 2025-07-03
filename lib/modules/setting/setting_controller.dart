import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';

class SettingController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();
  Rx<AppUser?> get user => _authService.currentUser;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> refreshUser() async {
    await _authService.getProfile();
  }

  void goToPrivacy() {
    Get.toNamed(AppRoutes.PRIVACY);
  }

  void goToSupport() {
    Get.toNamed(AppRoutes.SUPPORT);
  }

  logout() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
