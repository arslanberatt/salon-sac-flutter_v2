import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/controllers/transaction_controller.dart';

class DateTimeInput extends GetView<TransactionController> {
  const DateTimeInput({super.key});

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('d MMMM y - HH:mm', 'tr').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        title: const Text("Tarih ve Saat"),
        subtitle: Text(_formatDateTime(controller.date.value)),
        trailing: const Icon(Icons.calendar_today_rounded),
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: controller.date.value,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );

          if (pickedDate != null) {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(controller.date.value),
            );

            if (pickedTime != null) {
              controller.date.value = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            }
          }
        },
      ),
    );
  }
}
