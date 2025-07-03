import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_service.dart';
import 'package:salon_sac_flutter_v2/repositories/service_repository.dart';

class ServiceController extends BaseController {
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();
  final formKey = GlobalKey<FormState>();
  final name = ''.obs;
  final duration = 0.obs;
  final price = 0.0.obs;
  final allServices = <AppService>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadServices();
  }

  Future<void> refreshService() async {
    await loadServices();
  }

  Future<void> loadServices() async {
    setLoading(true);
    try {
      allServices.value = await _serviceRepository.getServices();
    } catch (e) {
      showErrorSnackbar(message: 'Servisler yüklenirken hata oluştu');
    } finally {
      setLoading(false);
    }
  }

  Future<void> createService() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    setLoading(true);
    try {
      final service = AppService(
        name: name.value,
        duration: duration.value,
        price: price.value,
      );
      await _serviceRepository.createService(service);
      showSuccessSnackbar(message: 'Hizmet oluşturuldu');
      await loadServices();
    } catch (e) {
      showErrorSnackbar(message: 'Hizmet oluşturulurken hata oluştu');
    } finally {
      setLoading(false);
    }
  }
}
