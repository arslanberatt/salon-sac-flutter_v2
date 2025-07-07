import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AppointmentCard extends GetView<AppointmentController> {
  final AppAppointment appointment;
  final String? header;

  const AppointmentCard({super.key, required this.appointment, this.header});

  @override
  Widget build(BuildContext context) {
    final emp =
        (appointment.employee?.name != null &&
            appointment.employee?.lastname != null)
        ? appointment.employee!
        : controller.employees.firstWhere(
            (u) => u.id == appointment.employee?.id,
            orElse: () => AppUser(
              id: appointment.employee?.id ?? '',
              name: 'Bilinmiyor',
              lastname: '',
            ),
          );

    final totalDuration = appointment.services.fold<int>(
      0,
      (s, e) => s + (e.duration ?? 0),
    );
    final endTime = appointment.startTime?.add(
      Duration(minutes: totalDuration),
    );
    final dateFmt = DateFormat('dd MMM yyyy   HH:mm', 'tr_TR');
    final timeFmt = DateFormat('HH:mm', 'tr_TR');

    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${emp.name} ${emp.lastname}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  _statusBadge(appointment),
                ],
              ),
              Text(
                appointment.customerName ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spacingS),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${dateFmt.format(appointment.startTime!)} - ${timeFmt.format(endTime!)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                NumberFormat.currency(
                  symbol: '₺',
                  decimalDigits: 2,
                  locale: 'tr_TR',
                ).format(appointment.price ?? 0),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightCard
                      : AppColors.darkCard,
                ),
              ),
            ],
          ),
          Divider(height: AppSizes.spacingM),
        ],
      ),
    );
  }

  Widget _statusBadge(AppAppointment appt) {
    String label;
    Color text;

    if (appt.isDone == true) {
      label = 'Tamamlandı';
      text = Colors.green.shade800;
    } else if (appt.isCancelled == true) {
      label = 'İptal Edildi';
      text = Colors.red.shade800;
    } else {
      label = 'Beklemede';
      text = Colors.orange.shade800;
    }

    return Text(
      label,
      style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }
}
