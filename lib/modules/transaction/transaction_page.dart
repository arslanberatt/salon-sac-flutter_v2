import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/add_category_dialog.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/date_input.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/save_button.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/controllers/transaction_controller.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/amount_input.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/category_dropdown.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/description_input.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/transaction_type_selector.dart';

class TransactionPage extends GetView<TransactionController> {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(AppSizes.paddingM),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TransactionTypeSelector(),
                      SizedBox(height: AppSizes.spacingM),
                      Row(
                        children: [
                          Expanded(child: CategoryDropdown()),
                          IconButton(
                            onPressed: () async {
                              final newCategory = await Get.dialog(
                                AddCategoryDialog(),
                              );
                              if (newCategory != null) {
                                await controller.loadCategories();
                                controller.selectedCategoryId.value =
                                    newCategory.id!;
                              }
                            },
                            icon: Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.spacingM),
                      AmmountInput(),
                      SizedBox(height: AppSizes.spacingM),
                      DescriptionInput(),
                      SizedBox(height: AppSizes.spacingM),
                      DateTimeInput(),
                      SizedBox(height: AppSizes.spacingM),
                      SaveButton(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
