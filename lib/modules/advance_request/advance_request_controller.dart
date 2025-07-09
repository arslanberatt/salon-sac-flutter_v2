import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_advance.dart';
import 'package:salon_sac_flutter_v2/repositories/advance_repository.dart';

class AdvanceRequestController extends BaseController {
  final AdvanceRepository _repo = Get.find();

  final myRequests = <AppAdvance>[].obs;
  final amount = 0.obs;
  final reason = ''.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    loadMyRequests();
  }

  Future<void> loadMyRequests() async {
    setLoading(true);

    try {
      final list = await _repo.getMyAdvances();
      final oneYearAgo = DateTime.now().subtract(const Duration(days: 365));
      final filtered = list
          .where((e) => e.createdAt != null && e.createdAt!.isAfter(oneYearAgo))
          .toList();

      filtered.sort(
        (a, b) => b.createdAt!.compareTo(a.createdAt!),
      ); // yeni üstte

      myRequests.value = filtered;
    } catch (e) {
      showErrorSnackbar(message: 'Avanslar yüklenemedi');
    } finally {
      setLoading(false);
    }
  }

  Future<void> submit() async {
    setLoading(true);
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    try {
      await _repo.createAdvance(amount.value, reason.value);
      await loadMyRequests();
      showSuccessSnackbar(message: 'Avans talebi oluşturuldu!');
      formKey.currentState!.reset();
    } catch (e) {
      showErrorSnackbar(message: 'Avans talebi oluşturulamadı!');
    } finally {
      setLoading(false);
    }
  }
}
