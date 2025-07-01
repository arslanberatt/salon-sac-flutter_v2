import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';

class NameInput extends GetView<ServiceController> {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Hizmet',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.description_outlined),
      ),
      onChanged: (value) {
        controller.name.value = value;
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
