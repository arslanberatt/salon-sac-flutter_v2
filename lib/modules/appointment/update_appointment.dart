import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_service.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/service_repository.dart';

class UpdateServiceController extends BaseController {
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();
  final formKey = GlobalKey<FormState>();
  final name = ''.obs;
  final duration = 0.obs;
  final price = 0.0.obs;
  final allServices = <AppService>[].obs;

  AppService? editingService;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is AppService) {
      editingService = arg;
      name.value = arg.name ?? '';
      duration.value = arg.duration ?? 0;
      price.value = arg.price ?? 0.0;
    }
  }

  Future<void> updateService(AppService service) async {
    setLoading(true);
    try {
      await _serviceRepository.updateService(service);
      Get.find<ServiceController>().refreshService();
      Get.back();
      showSuccessSnackbar(message: 'Hizmet başarıyla güncellendi');
    } catch (e) {
      showErrorSnackbar(message: 'Hizmet güncellenirken hata oluştu');
    } finally {
      setLoading(false);
    }
  }
}
