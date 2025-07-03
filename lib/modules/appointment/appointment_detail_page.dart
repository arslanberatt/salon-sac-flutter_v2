import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AppointmentDetailPage extends StatelessWidget {
  const AppointmentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppAppointment appt = Get.arguments as AppAppointment;
    final totalDuration = appt.services.fold<int>(
      0,
      (sum, s) => sum + (s.duration ?? 0),
    );
    final endTime = appt.startTime?.add(Duration(minutes: totalDuration));
    final fmtDate = DateFormat('dd MMM yyyy, HH:mm', 'tr_TR');
    final fmtTime = DateFormat('HH:mm', 'tr_TR');

    return Scaffold(
      appBar: AppBar(title: const Text('Randevu Detay')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: ListView(
          children: [
            _row(
              'Personel:',
              '${appt.employee?.name} ${appt.employee?.lastname}',
            ),
            _row('Müşteri:', appt.customerName ?? '-'),
            _row('Telefon:', appt.customerPhone ?? '-'),
            _row('Başlangıç:', fmtDate.format(appt.startTime!)),
            if (endTime != null) _row('Bitiş:', fmtTime.format(endTime)),
            _row('Toplam Süre:', '$totalDuration dk'),
            _sectionTitle('Hizmetler'),
            ...appt.services.map(
              (s) => ListTile(
                title: Text(s.name ?? ''),
                subtitle: Text('${s.duration} dk · ₺${s.price}'),
              ),
            ),
            _row('Notlar:', appt.notes ?? '-'),
            _row('Ücret:', '₺${appt.price?.toStringAsFixed(2) ?? '0.00'}'),
            _row(
              'Durum:',
              appt.isDone == true
                  ? 'Tamamlandı'
                  : appt.isCancelled == true
                  ? 'İptal edildi'
                  : 'Beklemede',
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(flex: 3, child: Text(value)),
      ],
    ),
  );

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 4),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}
