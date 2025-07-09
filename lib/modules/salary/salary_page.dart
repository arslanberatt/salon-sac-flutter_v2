import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/models/app_salary.dart';
import 'package:salon_sac_flutter_v2/modules/salary/salary_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class SalaryPage extends GetView<SalaryController> {
  const SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final filtered = controller.salaries
            .where((s) => s.type != 'maas')
            .toList();

        return RefreshIndicator(
          onRefresh: controller.loadMySalaryRecords,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SummaryRow(
                title: 'Toplam Prim',
                value: controller.totalBonus,
                color: AppColors.success,
              ),
              _SummaryRow(
                title: 'Toplam Avans',
                value: controller.totalAdvance,
                color: AppColors.error,
              ),
              const SizedBox(height: 20),
              const Text(
                'Geçmiş İşlemler',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...filtered.map((s) => _SalaryTile(s)).toList(),
            ],
          ),
        );
      }),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final double value;
  final Color color;

  const _SummaryRow({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
          Text('${value.toStringAsFixed(0)} ₺', style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

class _SalaryTile extends StatelessWidget {
  final AppSalary s;

  const _SalaryTile(this.s);

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy – HH:mm', 'tr_TR').format(s.date!);
    final color = s.type == 'prim' ? AppColors.success : AppColors.error;
    final icon = s.type == 'prim' ? Icons.percent : Icons.money_off;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(icon, color: color),
      title: Text(s.description ?? '-'),
      subtitle: Text(date),
      trailing: Text(
        '${s.amount?.toStringAsFixed(0) ?? '0'} ₺',
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
