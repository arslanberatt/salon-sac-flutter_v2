import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginController extends BaseController {
  late final AuthService _authService;
  final email = ''.obs;
  final password = ''.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _authService = Get.find<AuthService>();
  }

  Future<void> loginWithEmail() async {
    try {
      if (!formKey.currentState!.validate()) return;
      setLoading(true);
      final user = await _authService.login(
        email: email.value,
        password: password.value,
      );
      if (user != null) {
        if (user.isAdmin == true) {
          Get.offAllNamed(AppRoutes.ADMIN);
        } else {
          Get.offAllNamed(AppRoutes.EMPLOYEE);
        }
      } else {
        Get.snackbar('Hata', 'Giriş başarısız.');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Giriş sırasında bir hata oluştu.');
    } finally {
      setLoading(false);
    }
  }
}
