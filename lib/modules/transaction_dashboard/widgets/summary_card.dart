import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class SummaryCard extends GetView<TransactionDashboardController> {
  final String title;
  final double amount;
  final IconData icon;
  final Color color;
  final List<Color> gradientColors;
  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final ammountFormat = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: '₺',
      decimalDigits: 0,
    );
    return Container(
      width: 150,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: color),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, color: AppColors.textWhite),
                  ),
                ),
              ],
            ),
            // Text(
            //   '${((controller.montlyIncome.value - controller.montlyExpense.value == amount) || (controller.montlyIncome.value == amount)) && amount > 0 ? '+ ' : ''}${ammountFormat.format(amount)}',
            //   style: TextStyle(fontSize: 18, color: color),
            // ),
          ],
        ),
      ),
    );
  }
}
