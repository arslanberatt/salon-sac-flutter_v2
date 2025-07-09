import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class RegisterController extends BaseController {
  late final AuthService _authService;

  final name = ''.obs;
  final lastname = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
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

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    try {
      setLoading(true);

      final user = await _authService.register(
        name: name.value,
        lastname: lastname.value,
        email: email.value,
        phone: phone.value,
        password: password.value,
      );

      final isLogged = user != null || await _authService.isAuthenticated();

      if (isLogged) {
        showSuccessSnackbar(
          message: 'Hesabınız oluşturuldu. Giriş yapabilirsiniz.',
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.LOGIN);
      } else {
        showErrorSnackbar(message: 'Bir sorun oluştu, tekrar deneyin.');
      }
    } catch (e) {
      showErrorSnackbar(message: 'Kayıt sırasında bir hata oluştu: $e');
    } finally {
      setLoading(false);
    }
  }

  void goToLogin() {
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
