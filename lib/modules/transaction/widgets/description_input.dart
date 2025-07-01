import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/controllers/transaction_controller.dart';

class DescriptionInput extends GetView<TransactionController> {
  const DescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Açıklama',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.description_outlined),
      ),
      onChanged: (value) {
        controller.description.value = value;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Açıklama giriniz';
        }
        return null;
      },
    );
  }
}