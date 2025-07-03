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
      keyboardType: TextInputType.number,
      onChanged: (value) {
        controller.duration.value = int.tryParse(value) ?? 0;
      },
      validator: (value) {
        if (value == null || value.isEmpty) return 'Süre giriniz';
        final numValue = int.tryParse(value);
        if (numValue == null || numValue <= 0) return 'Geçersiz süre';
        return null;
      },
    );
  }
}
