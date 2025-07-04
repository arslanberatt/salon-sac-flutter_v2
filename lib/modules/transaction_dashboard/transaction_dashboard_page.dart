import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/custom_appbar.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/widgets/summary_card.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/widgets/transaction_list.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class TransactionDashboardPage extends GetView<TransactionDashboardController> {
  const TransactionDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  SummaryCard(
                    title: 'Aylık Gelir',
                    amount: controller.montlyIncome.value,
                    icon: Icons.arrow_upward,
                    color: AppColors.textWhite,
                    gradientColors: [
                      AppColors.success.withOpacity(0.5),
                      AppColors.success.withOpacity(0.7),
                    ],
                  ),
                  SummaryCard(
                    title: 'Aylık Gider', // ✅ düzeltildi
                    amount: controller.montlyExpense.value,
                    icon: Icons.arrow_downward,
                    color: AppColors.textWhite,
                    gradientColors: [
                      AppColors.error.withOpacity(0.5),
                      AppColors.error.withOpacity(0.7),
                    ],
                  ),
                  SummaryCard(
                    title: 'Aylık Bakiye',
                    amount:
                        controller.montlyIncome.value -
                        controller.montlyExpense.value,
                    icon: Icons.account_balance_wallet,
                    color: AppColors.textWhite,
                    gradientColors: [
                      AppColors.accent.withOpacity(0.5),
                      AppColors.accent.withOpacity(0.7),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(flex: 10, child: TransactionList()),
          ],
        );
      }),
    );
  }
}
