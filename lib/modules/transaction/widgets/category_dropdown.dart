import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/controllers/transaction_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class CategoryDropdown extends GetView<TransactionController> {
  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownMenu<String>(
        width: MediaQuery.of(context).size.width - 80,
        menuHeight: 240,
        hintText: 'Kategori Seç',
        initialSelection: controller.selectedCategoryId.value.isEmpty
            ? null
            : controller.selectedCategoryId.value,
        onSelected: (value) {
          if (value != null) controller.selectedCategoryId.value = value;
        },
        dropdownMenuEntries: controller.categories
            .where((cat) => cat.type == controller.transactionType.value)
            .map((cat) => DropdownMenuEntry(value: cat.id!, label: cat.name!))
            .toList(),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.textWhite),
          elevation: WidgetStatePropertyAll(8),
          shadowColor: WidgetStatePropertyAll(Colors.black26),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
              side: BorderSide(color: AppColors.inputBorder, width: 1.5),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
          ),
        ),
      ),
    );
  }
}
