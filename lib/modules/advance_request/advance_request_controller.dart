import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_advance.dart';
import 'package:salon_sac_flutter_v2/repositories/advance_repository.dart';

class AdvanceRequestController extends GetxController {
  final AdvanceRepository _repo = Get.find();

  final myRequests = <AppAdvance>[].obs;
  final amount = 0.obs;
  final reason = ''.obs;
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMyRequests();
  }

  Future<void> loadMyRequests() async {
    isLoading.value = true;
    try {
      final list = await _repo.getMyAdvances();
      myRequests.value = list.reversed.toList();
    } catch (e) {
      Get.snackbar('Hata', 'Avanslar yüklenemedi');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    try {
      await _repo.createAdvance(amount.value, reason.value);
      await loadMyRequests();
      Get.snackbar('Başarılı', 'Avans talebi oluşturuldu');
      formKey.currentState!.reset();
    } catch (e) {
      Get.snackbar('Hata', 'Avans talebi oluşturulamadı');
    }
  }
}
