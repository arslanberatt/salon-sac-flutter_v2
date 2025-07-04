import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/modules/employee_history/employee_history_controller.dart';

class EmployeeHistoryPage extends GetView<EmployeeHistoryController> {
  const EmployeeHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = controller.employee;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.name} ${user.lastname}'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bilgiler'),
              Tab(text: 'Randevular'),
            ],
          ),
        ),
        body: TabBarView(
          children: [_buildInfoTab(user), _buildAppointmentsTab()],
        ),
      ),
    );
  }

  Widget _buildInfoTab(AppUser user) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Ad Soyad"),
          subtitle: Text('${user.name ?? ''} ${user.lastname ?? ''}'),
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          title: const Text("Telefon"),
          subtitle: Text(user.phone ?? '-'),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text("E-posta"),
          subtitle: Text(user.email ?? '-'),
        ),
        ListTile(
          leading: const Icon(Icons.attach_money),
          title: const Text("Maaş"),
          subtitle: Text('${user.salary ?? 0} ₺'),
        ),
        ListTile(
          leading: const Icon(Icons.percent),
          title: const Text("Komisyon Oranı"),
          subtitle: Text('%${user.commissionRate ?? 0}'),
        ),
        ListTile(
          leading: const Icon(Icons.badge),
          title: const Text("Rol"),
          subtitle: Text(getRole(user)),
        ),
      ],
    );
  }

  Widget _buildAppointmentsTab() {
    return Obx(() {
      final list = controller.appointments;
      if (list.isEmpty) {
        return const Center(child: Text("Henüz randevu geçmişi yok."));
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final appt = list[index];
          final services = appt.services.map((s) => s.name).join(', ');
          final date = DateFormat(
            'dd MMMM yyyy – HH:mm',
            'tr_TR',
          ).format(appt.startTime!);
          return ListTile(
            title: Text(appt.customerName ?? '-'),
            subtitle: Text('$services\n$date'),
            isThreeLine: true,
            trailing: Text('${appt.price?.toStringAsFixed(0) ?? "0"} ₺'),
          );
        },
      );
    });
  }

  String getRole(AppUser user) {
    if (user.isAdmin == true) return 'Patron';
    if (user.isMod == true) return 'Çalışan';
    return 'Misafir';
  }
}
