import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';

class LoginController extends BaseController {
  late final AuthService _authService;
  final email = ''.obs;
  final password = ''.obs;
  final rememberMe = false.obs;
  final isPasswordVisible = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _authService = Get.find<AuthService>();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginWithEmail() async {
    if (!formKey.currentState!.validate()) return;
    try {
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
        Get.snackbar('Hata', 'Giriş başarısız. Lütfen bilgileri kontrol edin.');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Giriş sırasında bir hata oluştu.');
    } finally {
      setLoading(false);
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  void forgotPassword() {
    Get.offAllNamed(AppRoutes.FORGOTPASSWORD);
  }
}
