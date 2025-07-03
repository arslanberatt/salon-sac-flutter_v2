import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/appointment_controller.dart';

class AppointmentSaveButton extends GetView<AppointmentController> {
  const AppointmentSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await controller.createAppointment();
      },
      child: const SizedBox(
        width: double.infinity,
        child: Text('Kaydet', textAlign: TextAlign.center),
      ),
    );
  }
}
