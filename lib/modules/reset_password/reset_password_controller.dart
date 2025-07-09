import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/user_repository.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';
import 'package:salon_sac_flutter_v2/services/storage_service.dart';

class ResetPasswordController extends BaseController {
  final email = ''.obs;
  final code = ''.obs;
  final newPassword = ''.obs;

  final emailFormKey = GlobalKey<FormState>();
  final codeFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  final _userRepo = Get.find<UserRepository>();
  final _storage = Get.find<StorageService>();

  late final String? tokenFromArgs;

  @override
  void onInit() {
    super.onInit();

    // Eğer token Get.arguments ile geldiyse al
    tokenFromArgs = Get.arguments?['token'];
    if (tokenFromArgs != null) {
      _storage.setValue<String>(StorageKeys.temporaryToken, tokenFromArgs!);
    }
  }

  /// 1. Aşama: E-posta ile kod gönder
  Future<void> sendResetCode() async {
    if (!emailFormKey.currentState!.validate()) return;

    setLoading(true);
    final result = await _userRepo.sendResetCode(email.value);
    setLoading(false);

    if (result) {
      showSuccessSnackbar(message: 'Kod e-posta adresine gönderildi');
      Get.toNamed(AppRoutes.RESETCODE);
    } else {
      showErrorSnackbar(message: 'Kod gönderilemedi. E-posta doğru mu?');
    }
  }

  /// 2. Aşama: Kod doğrulama ve token saklama
  Future<void> verifyResetCode() async {
    if (!codeFormKey.currentState!.validate()) return;

    setLoading(true);
    final token = await _userRepo.verifyResetCode(
      email: email.value,
      code: code.value,
    );
    setLoading(false);

    if (token != null && token.isNotEmpty) {
      await _storage.setValue<String>(StorageKeys.temporaryToken, token);
      showSuccessSnackbar(message: 'Kod doğrulandı, yeni şifre belirleyin');
      Get.toNamed(AppRoutes.RESETPASSWORD, arguments: {'token': token});
    } else {
      showErrorSnackbar(message: 'Kod geçersiz veya süresi dolmuş.');
    }
  }

  /// 3. Aşama: Yeni şifre belirleme
  Future<void> resetPassword() async {
    if (!passwordFormKey.currentState!.validate()) return;
    final token = _storage.getValue<String>(StorageKeys.temporaryToken);
    if (token == null || token.isEmpty) {
      showErrorSnackbar(message: 'Token bulunamadı. Yeniden deneyin.');
      return;
    }

    setLoading(true);
    final success = await _userRepo.resetPassword(token, newPassword.value);
    setLoading(false);

    if (success) {
      await _storage.remove(StorageKeys.temporaryToken);
      showSuccessSnackbar(
        message: 'Şifreniz güncellendi. Giriş yapabilirsiniz.',
      );
      Get.offAllNamed(AppRoutes.LOGIN);
    } else {
      showErrorSnackbar(
        message: 'Şifre güncellenemedi. Lütfen tekrar deneyin.',
      );
    }
  }
}
