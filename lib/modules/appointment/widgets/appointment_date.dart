import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';

class AppointmentDate extends GetView<AppointmentController> {
  const AppointmentDate({super.key});

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('d MMMM y - HH:mm', 'tr_TR').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        title: const Text('Tarih ve Saat'),
        subtitle: Text(_formatDateTime(controller.selectedDate.value)),
        trailing: const Icon(Icons.calendar_today_rounded),
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: controller.selectedDate.value,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );
          if (pickedDate != null) {
            final pickedTime = await showTimePicker(
              // ignore: use_build_context_synchronously
              context: context,
              initialTime: TimeOfDay.fromDateTime(
                controller.selectedDate.value,
              ),
            );
            if (pickedTime != null) {
              controller.setDate(
                DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
