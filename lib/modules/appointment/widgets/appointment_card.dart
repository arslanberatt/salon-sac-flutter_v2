import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AppointmentCard extends StatelessWidget {
  final AppAppointment appointment;
  final String? header;

  const AppointmentCard({super.key, required this.appointment, this.header});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentController>();

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
    final dateFmt = DateFormat('dd MMM yyyy – HH:mm', 'tr_TR');
    final timeFmt = DateFormat('HH:mm', 'tr_TR');

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                header!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${emp.name} ${emp.lastname}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    appointment.customerName ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Text(
                DateFormat('dd MMM', 'tr_TR').format(appointment.startTime!),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                dateFmt.format(appointment.startTime!),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (endTime != null)
                Text(
                  ' - ${timeFmt.format(endTime)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  appointment.notes ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Text(
                NumberFormat.currency(
                  symbol: '₺',
                  decimalDigits: 2,
                  locale: 'tr_TR',
                ).format(appointment.price ?? 0),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.primaryDark),
              ),
            ],
          ),
          Divider(height: AppSizes.spacingM),
        ],
      ),
    );
  }
}
