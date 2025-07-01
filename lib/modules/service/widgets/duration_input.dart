import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';

class DurationInput extends GetView<ServiceController> {
  const DurationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Süre',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.timer_outlined),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) {
        controller.duration.value = value as int;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Süre giriniz';
        }
        final numValue = num.tryParse(value);
        if (numValue == null || numValue <= 0) {
          return 'Geçersiz süre';
        }
        return null;
      },
    );
  }
}
