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
  print("SettingController loaded. user: ${user.value?.toJson()}");
}


  logout() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
