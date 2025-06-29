import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_page.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/date_input.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/save_button.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/transaction_controller.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/amount_input.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/category_dropdown.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/description_input.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/widgets/transaction_type_selector.dart';

class TransactionPage extends GetView<TransactionController> {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
                            onPressed: () {},
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
