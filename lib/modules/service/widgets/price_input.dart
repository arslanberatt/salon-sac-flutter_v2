import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';

class PriceInput extends GetView<ServiceController> {
  const PriceInput({super.key});

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
        controller.price.value = double.tryParse(value)!;
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
