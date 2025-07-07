import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_advance.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/advance_repository.dart';

class AdvanceController extends GetxController {
  final AdvanceRepository _repo = Get.find();

  final allRequests = <AppAdvance>[].obs;
  final approved = <AppAdvance>[].obs;
  final rejected = <AppAdvance>[].obs;
  final pendingCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAdvanceRequests();
  }

  Future<void> loadAdvanceRequests() async {
    try {
      final all = await _repo.getAll();

      allRequests.value = all;

      final sorted = all.toList()
        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      approved.value = sorted.where((r) => r.status == 'onaylandi').toList();
      rejected.value = sorted.where((r) => r.status == 'reddedildi').toList();
      pendingCount.value = sorted.where((r) => r.status == 'beklemede').length;
    } catch (e) {
      Get.snackbar('Hata', 'Avans talepleri yüklenemedi');
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      await _repo.updateStatus(id, status);
      await loadAdvanceRequests();
      Get.find<TransactionDashboardController>().refreshDashboard();
      Get.snackbar('Başarılı', 'Avans "$status" olarak güncellendi');
    } catch (e) {
      Get.snackbar('Hata', 'Durum güncellenemedi');
    }
  }
}
