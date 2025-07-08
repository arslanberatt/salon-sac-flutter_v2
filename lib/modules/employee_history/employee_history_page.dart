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
    final isAdminUser = user.isAdmin == true;

    return DefaultTabController(
      length: isAdminUser ? 2 : 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Salon Saç',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightCard
                : AppColors.darkCard,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightCard
                : AppColors.darkCard,
            tabs: [
              const Tab(text: 'Bilgiler'),
              const Tab(text: 'Randevular'),
              if (!isAdminUser) const Tab(text: 'İşlemler'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInfoTab(context, user),
            _buildAppointmentsTab(),
            if (!isAdminUser) _buildSalaryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab(BuildContext context, AppUser user) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      children: [
        const SizedBox(height: AppSizes.paddingM),
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
        const SizedBox(height: AppSizes.spacingXL),
        _infoRow(
          context,
          Icons.fingerprint,
          "Kullanıcı ID",
          user.id ?? '-',
          12,
        ),
        const Divider(height: AppSizes.spacingM * 2),
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
                        context,
                        Icons.person_outline,
                        "Adı Soyadı",
                        '${user.name!} ${user.lastname!}',
                        14,
                      ),
                      _infoRow(
                        context,
                        Icons.attach_money,
                        "Maaş",
                        '${user.salary ?? 0} ₺',
                        14,
                      ),
                      _infoRow(
                        context,
                        Icons.email_outlined,
                        "Email Adresi",
                        user.email!,
                        11,
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
                        context,
                        Icons.verified_user_outlined,
                        "Rol",
                        user.isAdmin! ? "Admin" : "Çalışan",
                        14,
                      ),
                      _infoRow(
                        context,
                        Icons.work_outline,
                        "Prim Oranı",
                        "${user.commissionRate}%",
                        14,
                      ),
                      _infoRow(
                        context,
                        Icons.phone_outlined,
                        "Telefon Numarası",
                        user.phone!,
                        14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!user.isAdmin!)
          Obx(
            () => Container(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bu Ayki Maaş Detayı',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingM),
                  _infoRow(
                    context,
                    Icons.work_outline,
                    'Sabit Maaş',
                    '${user.salary ?? 0} ₺',
                    14,
                  ),
                  _infoRow(
                    context,
                    Icons.percent,
                    'Bu Ay ki Prim',
                    '${controller.totalBonus.toStringAsFixed(0)} ₺',
                    14,
                  ),
                  _infoRow(
                    context,
                    Icons.money_off,
                    'Bu Ay ki Avans',
                    '${controller.totalAdvance.toStringAsFixed(0)} ₺',
                    14,
                  ),
                  const Divider(),
                  _infoRow(
                    context,
                    Icons.monetization_on,
                    'Net Ödenecek Maaş',
                    '${controller.monthlyNetSalary.toStringAsFixed(0)} ₺',
                    16,
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
              style: const TextStyle(fontSize: 16),
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
}

Widget _infoRow(
  BuildContext context,
  IconData icon,
  String label,
  String value,
  double font,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingXS),
    child: Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.lightCard
              : AppColors.darkCard,
        ),
        const SizedBox(width: AppSizes.paddingS),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: font,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightCard
                      : AppColors.darkCard,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
