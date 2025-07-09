import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/custom_appbar.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/appointment_card.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class CalendarPage extends GetView<AppointmentController> {
  CalendarPage({super.key});
  final user = Get.find<AuthService>().currentUser.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (user != null && user?.isAdmin == true)
          ? const CustomAppBar()
          : AppBar(
              title: Text(
                'Salon Saç',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
      body: Column(
        children: [
          Obx(() {
            return TableCalendar(
              locale: 'tr_TR',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: controller.selectedDate.value,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarFormat: CalendarFormat.week,
              availableCalendarFormats: {CalendarFormat.week: 'Haftalık'},
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(Icons.chevron_left, size: 24),
                rightChevronIcon: Icon(Icons.chevron_right, size: 24),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(color: AppColors.error),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
                markerDecoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                markerSizeScale: 0.15,
                cellPadding: const EdgeInsets.all(6),
              ),
              selectedDayPredicate: (day) =>
                  isSameDay(day, controller.selectedDate.value),
              onDaySelected: (selectedDay, focusedDay) =>
                  controller.setDate(selectedDay),
            );
          }),
          const SizedBox(height: 12),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primaryDark,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              displacement: 40,
              onRefresh: controller.refreshAppointments,
              child: Obx(() {
                final list = controller.filteredAppointments;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: list.isEmpty ? 1 : list.length,
                  itemBuilder: (context, index) {
                    if (list.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Text('Seçilen gün için randevu yok'),
                        ),
                      );
                    }

                    final appt = list[index];
                    return Dismissible(
                      direction:
                          (appt.isDone == true || appt.isCancelled == true)
                          ? DismissDirection.startToEnd
                          : DismissDirection.horizontal,
                      key: ValueKey(appt.id),
                      background: Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        color: AppColors.success.withOpacity(0.2),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          Get.toNamed(
                            AppRoutes.APPOINTMENTDETAIL,
                            arguments: appt,
                          );
                          return false;
                        } else if (direction == DismissDirection.endToStart) {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Onay'),
                              content: const Text(
                                'Bu randevuyu tamamlamak istediğinize emin misiniz?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(false),
                                  child: const Text('Hayır'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(true),
                                  child: const Text('Evet'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await controller.markDone(appt.id!);
                          }
                          return false;
                        }
                        return false;
                      },
                      child: AppointmentCard(appointment: appt),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
