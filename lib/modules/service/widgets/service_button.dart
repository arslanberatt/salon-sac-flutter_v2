import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';

class ServiceButton extends GetView<ServiceController> {
  const ServiceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await controller.createService();
      },
      child: const SizedBox(
        width: double.infinity,
        child: Text('Kaydet', textAlign: TextAlign.center),
      ),
    );
  }
}
