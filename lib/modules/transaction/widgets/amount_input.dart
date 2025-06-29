import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/transaction_controller.dart';

class AmmountInput extends GetView<TransactionController> {
  const AmmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Miktar',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money_outlined),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) {
        controller.amount.value =
            double.tryParse(value) ?? controller.amount.value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Miktarı giriniz';
        }
        final amount = double.tryParse(value);
        if (amount == null || amount <= 0) {
          return 'Geçersiz miktar';
        }
        return null;
      },
    );
  }
}
