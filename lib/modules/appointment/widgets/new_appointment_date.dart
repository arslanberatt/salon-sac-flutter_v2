import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewAppointmentDate extends StatelessWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const NewAppointmentDate({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Tarih: ${initialDate != null ? DateFormat('dd MMM yyyy, HH:mm', 'tr_TR').format(initialDate!) : 'Seçilmedi'}',
      ),
      trailing: Icon(Icons.calendar_today),
      onTap: () async {
        final now = DateTime.now();
        final date = await showDatePicker(
          context: context,
          initialDate: initialDate ?? now,
          firstDate: now.subtract(Duration(days: 365)),
          lastDate: now.add(Duration(days: 365)),
        );

        if (date == null) return;

        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate ?? now),
        );

        if (time == null) return;

        final selected = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        onDateSelected(selected); // controller’a yaz
      },
    );
  }
}
