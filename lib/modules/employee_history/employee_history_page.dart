import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/modules/employee_history/employee_history_controller.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class EmployeeHistoryPage extends GetView<EmployeeHistoryController> {
  const EmployeeHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = controller.employee;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Salon Saç',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bilgiler'),
              Tab(text: 'Randevular'),
              Tab(text: 'Gelirler'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInfoTab(user),
            _buildAppointmentsTab(),
            _buildSalaryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab(AppUser user) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      children: [
        SizedBox(height: AppSizes.paddingM),
        Center(
          child: CircleAvatar(
            radius: 64,
            backgroundColor: Colors.grey.shade300,
            child: ClipOval(
              child: Image.network(
                '${ApiConstants.baseUrl}${user.avatar}',
                width: 140,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.person,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSizes.spacingXL),
        Divider(height: AppSizes.spacingM * 2),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow(
                        Icons.person_outline,
                        "Adı Soyadı",
                        '${user.name!} ${user.lastname!}',
                      ),
                      _infoRow(
                        Icons.attach_money,
                        "Maaş",
                        '${user.salary ?? 0} ₺',
                      ),
                      _infoRow(
                        Icons.email_outlined,
                        "Email Adresi",
                        user.email!,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow(
                        Icons.verified_user_outlined,
                        "Rol",
                        user.isAdmin! ? "Admin" : "Çalışan",
                      ),
                      _infoRow(
                        Icons.work_outline,
                        "Prim Oranı",
                        "${user.commissionRate}%",
                      ),
                      _infoRow(
                        Icons.phone_outlined,
                        "Telefon Numarası",
                        user.phone!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            trailing: Text(
              '${appt.price?.toStringAsFixed(0) ?? "0"} ₺',
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      );
    });
  }

  Widget _buildSalaryTab() {
    return Obx(() {
      final list = controller.salaryRecords;
      if (list.isEmpty) {
        return const Center(child: Text("Henüz gelir kaydı yok."));
      }
      return ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final r = list[index];
          final date = DateFormat(
            'dd MMM yyyy – HH:mm',
            'tr_TR',
          ).format(r.date!);
          final type = r.type == 'prim'
              ? 'Prim'
              : r.type == 'avans'
              ? 'Avans'
              : 'Gelir';

          return ListTile(
            leading: Icon(
              r.type == 'prim'
                  ? Icons.percent
                  : r.type == 'avans'
                  ? Icons.money_off
                  : Icons.monetization_on,
            ),
            title: Text('$type - ${r.amount?.toStringAsFixed(0) ?? 0} ₺'),
            subtitle: Text(r.description ?? ''),
            trailing: Text(date, style: const TextStyle(fontSize: 12)),
          );
        },
      );
    });
  }

  String getRole(AppUser user) {
    if (user.isAdmin == true) return 'Patron';
    if (user.isMod == true) return 'Moderatör';
    if (user.isActive == true) return 'Çalışan';
    return 'Bu kullanıcının henüz bir rolü yok';
  }
}

Widget _infoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingXS),
    child: Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryDark),
        const SizedBox(width: AppSizes.paddingS),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
