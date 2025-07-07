import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_controller.dart';

class TransactionContainer extends GetView<TransactionDashboardController> {
  const TransactionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(16, 32, 56, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Kasa",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Obx(() {
                  final formatted = NumberFormat.currency(
                    locale: 'tr_TR',
                    symbol: '₺',
                    decimalDigits: 2,
                  ).format(controller.totalAmount.value);
                  return Text(
                    formatted,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
