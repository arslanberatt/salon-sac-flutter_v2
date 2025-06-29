import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class BaseController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setLoading(bool value) => _isLoading.value = value;

  void showErrorSnackbar({
    required String message,
    String title = 'Hata',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.isDarkMode
          ? AppColors.primaryLight
          : AppColors.primary,
      colorText: Get.isDarkMode ? AppColors.textPrimary : AppColors.textWhite,
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
      duration: duration,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      overlayBlur: 0.5,
      overlayColor: Colors.black12,
    );
  }

  void showSuccessSnackbar({
    required String message,
    String title = 'Başarılı',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.isDarkMode
          ? AppColors
                .success // örn: koyu yeşil
          : const Color.fromARGB(255, 89, 183, 93), // örn: açık yeşil
      colorText: Get.isDarkMode ? AppColors.textPrimary : AppColors.textWhite,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      duration: duration,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      overlayBlur: 0.5,
      overlayColor: Colors.black12,
    );
  }
}
