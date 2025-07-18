import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_category.dart';
import 'package:salon_sac_flutter_v2/models/app_transaction.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/category_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/transaction_repository.dart';

class TransactionController extends BaseController {
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();
  final TransactionRepository _transactionRepository =
      Get.find<TransactionRepository>();

  final categories = <AppCategory>[].obs;
  final selectedCategoryId = "".obs;
  final transactionType = "gelir".obs;
  final description = "gelir".obs;
  final amount = 0.0.obs;
  final date = DateTime.now().obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    await loadCategories();
    ever(transactionType, (callback) {
      getFirstCategory();
    });
  }

  Future<void> createTransaction() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    try {
      setLoading(true);

      final selectedCat = categories.firstWhere(
        (c) => c.id == selectedCategoryId.value,
        orElse: () => throw Exception('Kategori seçilmedi'),
      );

      final transaction = AppTransaction(
        amount: amount.value,
        description: description.value,
        date: date.value,
        category: Category(
          id: selectedCat.id,
          name: selectedCat.name,
          type: selectedCat.type,
        ),
        canceled: false,
        type: selectedCat.type,
      );
      await _transactionRepository.createTransaction(transaction);
      Get.find<TransactionDashboardController>().refreshDashboard();
      Get.back();
      showSuccessSnackbar(message: 'İşlem başarıyla eklendi');
      clearForm();
    } catch (e) {
      showErrorSnackbar(message: 'İşlem oluşturulamadı: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadCategories() async {
    setLoading(true);
    try {
      final result = await _categoryRepository.getCategories();
      categories.value = result;
      getFirstCategory();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  void getFirstCategory() {
    final filteredCategories = categories
        .where((category) => category.type == transactionType.value)
        .toList();
    if (filteredCategories.isNotEmpty) {
      selectedCategoryId.value = filteredCategories.first.id!;
    } else {
      selectedCategoryId.value = "";
    }
  }

  void clearForm() {
    amount.value = 0.0;
    description.value = '';
    date.value = DateTime.now();
    selectedCategoryId.value = '';
    transactionType.value = 'expense';
  }
}
