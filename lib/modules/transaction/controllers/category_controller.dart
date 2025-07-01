import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_category.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/controllers/transaction_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/category_repository.dart';

class CategoryController extends BaseController {
  final categoryName = ''.obs;
  final selectedIcon = ''.obs;
  final formKey = GlobalKey<FormState>();
  final categoryType = ''.obs;

  late final CategoryRepository categoryRepository;

  @override
  void onInit() {
    super.onInit();
    categoryRepository = Get.find<CategoryRepository>();
    categoryType.value =
        Get.find<TransactionController>().transactionType.value;
  }

  Future<void> createCategory() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    setLoading(true);
    try {
      var newCategory = AppCategory(
        name: categoryName.value,
        type: categoryType.value,
      );
      var addedCategory = await categoryRepository.createCategory(newCategory);
      Get.back(result: addedCategory);
    } catch (e) {
      showErrorSnackbar(
        message: 'Kategori oluşturulurken bir hata oluştu:\n${e.toString()}',
      );
    } finally {
      setLoading(false);
    }
  }
}
