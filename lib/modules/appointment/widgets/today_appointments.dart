import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/appointment_card.dart';

class TodaysAppointmentsList extends GetView<AppointmentController> {
  const TodaysAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Obx(() {
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      final list = controller.appointments.where((a) {
        final st = a.startTime;
        if (st == null) return false;
        return st.year == today.year &&
            st.month == today.month &&
            st.day == today.day;
      }).toList();

      if (list.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(child: Text('Bugün için randevu yok')),
        );
      }

      return Expanded(
        child: ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final appt = list[index];
            return AppointmentCard(appointment: appt);
          },
        ),
      );
    });
  }
}
