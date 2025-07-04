import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';

class RegisterController extends BaseController {
  late final AuthService _authService;
  final name = ''.obs;
  final lastname = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _authService = Get.find<AuthService>();
  }

  Future<void> registerUser() async {
    try {
      if (!formKey.currentState!.validate()) return;
      setLoading(true);
      final user = await _authService.register(
        name: name.value,
        lastname: lastname.value,
        email: email.value,
        phone: phone.value,
        password: password.value,
      );
      // Profil null olsa bile token kaydedildiyse başarılı say!
      if (user != null || await _authService.isAuthenticated()) {
        Get.snackbar(
          'Kayıt Başarılı',
          'Kullanıcı kaydı oluşturuldu. Giriş yapabilirsiniz.',
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed("/login");
      } else {
        Get.snackbar(
          'Kayıt Başarısız',
          'Kullanıcı kaydı oluşturulamadı. Lütfen bilgilerinizi kontrol edin.',
        );
      }
    } catch (e) {
      Get.snackbar('Kayıt Başarısız', 'Bir hata oluştu: $e');
    } finally {
      setLoading(false);
    }
  }
}
