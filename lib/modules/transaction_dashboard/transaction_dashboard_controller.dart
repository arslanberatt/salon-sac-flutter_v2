import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_transaction.dart';
import 'package:salon_sac_flutter_v2/repositories/transaction_repository.dart';

class TransactionDashboardController extends BaseController {
  late final TransactionRepository _transactionRepository;

  final montlyIncome = 0.0.obs;
  final montlyExpense = 0.0.obs;
  final totalAmount = 0.0.obs;
  final allTransactions = <AppTransaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    _transactionRepository = Get.find<TransactionRepository>();
    getTransactions();
  }

  Future<void> getTransactions() async {
    setLoading(true);
    try {
      final transactions = await _transactionRepository.getTransactions();
      allTransactions.value = transactions;
      calculateMonthlyTransactions();
      calculateTotalAmount();
    } catch (e) {
      showErrorSnackbar(message: "Kasa işlemleri çekilirken sorun oluştu!");
    } finally {
      setLoading(false);
    }
  }

  Future<void> refreshDashboard() async {
    await getTransactions();
  }

  void calculateTotalAmount() {
    totalAmount.value = allTransactions.where((t) => t.canceled != true).fold(
      0.0,
      (sum, t) {
        if (t.category?.type == 'gelir') {
          return sum + (t.amount ?? 0);
        } else if (t.category?.type == 'gider') {
          return sum - (t.amount ?? 0);
        }
        return sum;
      },
    );
  }

  void calculateMonthlyTransactions() {
    montlyIncome.value = 0.0;
    montlyExpense.value = 0.0;

    final now = DateTime.now();

    for (final tr in allTransactions) {
      if (tr.date == null || tr.canceled == true) continue;

      if (tr.date!.year == now.year && tr.date!.month == now.month) {
        if (tr.category?.type == 'gelir') {
          montlyIncome.value += tr.amount ?? 0;
        } else if (tr.category?.type == 'gider') {
          montlyExpense.value += tr.amount ?? 0;
        }
      }
    }
  }

  Future<void> cancelTransaction(String transactionId) async {
    try {
      setLoading(true);
      final result = await _transactionRepository.cancelTransaction(
        transactionId,
      );
      if (result != null) {
        final index = allTransactions.indexWhere((t) => t.id == transactionId);
        if (index != -1) {
          allTransactions[index] = result;
          allTransactions.refresh();
          calculateMonthlyTransactions();
          calculateTotalAmount();
          showSuccessSnackbar(message: 'İşlem iptal edildi!');
        }
      } else {
        showErrorSnackbar(
          message: 'İşlem zaten iptal edilmiş veya bulunamadı.',
        );
      }
    } catch (e) {
      showErrorSnackbar(message: 'İşlem iptal edilirken hata oluştu!');
    } finally {
      setLoading(false);
    }
  }
}
