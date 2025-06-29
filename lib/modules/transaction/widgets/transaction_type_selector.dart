import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/transaction_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class TransactionTypeSelector extends GetView<TransactionController> {
  const TransactionTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SegmentedButton(
        segments: [
          ButtonSegment(
            value: 'gelir',
            label: Text('Gelir'),
            icon: Icon(Icons.add_circle_outline_outlined),
          ),
          ButtonSegment(
            value: 'gider',
            label: Text('Gider'),
            icon: Icon(Icons.remove_circle_outline),
          ),
        ],
        selected: {controller.transactionType.value},
        onSelectionChanged: (selection) {
          controller.transactionType.value = selection.first;
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.inputBorder;
          }),
          foregroundColor: WidgetStateColor.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? Colors.white
                : AppColors.primaryDark;
          }),
        ),
      ),
    );
  }
}
