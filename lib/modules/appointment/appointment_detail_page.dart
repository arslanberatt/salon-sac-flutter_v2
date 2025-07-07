import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AppointmentDetailPage extends GetView<AppointmentController> {
  AppointmentDetailPage({super.key});

  final Rx<AppAppointment> appt = (Get.arguments as AppAppointment).obs;

  @override
  Widget build(BuildContext context) {
    final fmtDate = DateFormat('dd MMM yyyy, HH:mm', 'tr_TR');
    final fmtTime = DateFormat('HH:mm', 'tr_TR');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final a = appt.value;
        final totalDuration = a.services.fold<int>(
          0,
          (sum, s) => sum + (s.duration ?? 0),
        );
        final endTime = a.startTime?.add(Duration(minutes: totalDuration));

        return Padding(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          child: ListView(
            children: [
              _sectionTitle('TOPLAM ÜCRET'),
              const SizedBox(height: 4),
              Text(
                '₺${(a.price ?? 0).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightCard
                      : AppColors.darkCard,
                ),
              ),
              const SizedBox(height: 16),
              _sectionTitle('RANDEVU DETAYLARI'),
              const SizedBox(height: 8),
              _infoRow(
                'Personel',
                '${a.employee?.name} ${a.employee?.lastname}',
              ),
              _infoRow('Müşteri', a.customerName ?? '-'),
              _infoRow('Telefon', a.customerPhone ?? '-'),
              _infoRow('Başlangıç', fmtDate.format(a.startTime!)),
              if (endTime != null) _infoRow('Bitiş', fmtTime.format(endTime)),
              _infoRow('Toplam Süre', '$totalDuration dk'),
              const Divider(height: 32),
              _sectionTitle('HİZMETLER'),
              ...a.services.map(
                (s) => _infoRow(
                  s.name ?? '-',
                  '₺${s.price?.toStringAsFixed(2) ?? '-'}',
                ),
              ),
              const SizedBox(height: 16),
              _infoRow('Notlar', a.notes ?? '-'),
              _infoRow(
                'Durum',
                a.isDone == true
                    ? 'Tamamlandı'
                    : a.isCancelled == true
                    ? 'İptal edildi'
                    : 'Beklemede',
              ),
              const SizedBox(height: 32),
              if (a.isDone != true && a.isCancelled != true)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? AppColors.inputBorder
                              : AppColors.textWhite,
                          side: const BorderSide(color: AppColors.primary),
                          foregroundColor: AppColors.primary,
                        ),
                        onPressed: () async {
                          await controller.goToUpdate(appt.value);
                        },
                        child: const Text('Düzenle'),
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingS),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? AppColors.primaryLight
                              : AppColors.primary,
                          side: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.primaryLight
                                : AppColors.primary,
                          ),
                          foregroundColor: AppColors.textWhite,
                        ),
                        onPressed: () =>
                            controller.confirmAndCancel(appt.value.id!),
                        child: const Text('İptal Et'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppSizes.fontS,
            ),
          ),
        ),
        Expanded(flex: 3, child: Text(value)),
      ],
    ),
  );

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 4),
    child: Text(text, style: const TextStyle(fontSize: AppSizes.fontS)),
  );
}
