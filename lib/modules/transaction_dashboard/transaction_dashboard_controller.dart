import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_transaction.dart';
import 'package:salon_sac_flutter_v2/repositories/transaction_repository.dart';

class TransactionDashboardController extends BaseController {
  late final TransactionRepository _transactionRepository;

  final montlyIncome = 0.0.obs;
  final montlyExpense = 0.0.obs;

  void montlyTransaction() {
    montlyIncome.value = 0.0;
    montlyExpense.value = 0.0;
    var thisDate = DateTime.now();
    var thisYear = thisDate.year;
    var thisMonth = thisDate.month;

    if (allTransactions.isNotEmpty) {
      var filteredTransaction = allTransactions.where((transaction) {
        return transaction.date!.year == thisYear &&
            transaction.date!.month == thisMonth;
      }).toList();

      for (var tr in filteredTransaction) {
        if (tr.category?.type == 'gelir') {
          montlyIncome.value += tr.amount!;
        } else if (tr.category?.type == 'gider') {
          montlyExpense.value += tr.amount!;
        }
      }
    } else {
      montlyIncome.value = 0.0;
      montlyExpense.value = 0.0;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    _transactionRepository = Get.find<TransactionRepository>();
    await getTransactions();
  }

  Future<void> refreshDashboard() async {
    await getTransactions();
  }

  final allTransactions = <AppTransaction>[].obs;
  Future getTransactions() async {
    try {
      setLoading(true);
      final transactions = await _transactionRepository.getTransactions();
      allTransactions.value = transactions;
      montlyTransaction();
    } catch (e) {
      showErrorSnackbar(message: "Kasa işlemleri çekilirken sorun oluştu!");
    } finally {
      setLoading(false);
    }
  }

  Future<void> cancelTransaction(String transactionId) async {
    setLoading(true);
    try {
      final transactions = await _transactionRepository.cancelTransaction(
        transactionId,
      );
      allTransactions.removeWhere((element) => element.id == transactionId);
      montlyTransaction();
      showSuccessSnackbar(message: 'İşlem iptal edildi!');
    } catch (e) {
      showErrorSnackbar(message: 'İşlem iptal edilirken bir hata oluştu!');
    } finally {
      setLoading(false);
    }
  }
}
