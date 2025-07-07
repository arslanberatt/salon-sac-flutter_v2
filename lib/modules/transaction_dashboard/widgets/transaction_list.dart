import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/models/app_transaction.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class TransactionList extends GetView<TransactionDashboardController> {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final transactions = controller.allTransactions;

      if (transactions.isEmpty) {
        return const Center(child: Text('Henüz bir işlem yok'));
      }

      return ListView.separated(
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          final cat = tx.category;

          final isIncome = cat?.type == 'gelir';
          final isCanceled = tx.canceled == true;
          final brightness = Theme.of(context).brightness;

          return Dismissible(
            key: ValueKey(tx.id),
            direction: isCanceled
                ? DismissDirection.startToEnd
                : DismissDirection.horizontal,
            background: Container(
              color: Colors.blueGrey.withOpacity(0.1),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.info_outline, color: Colors.blueGrey),
            ),
            secondaryBackground: Container(
              color: Colors.red.withOpacity(0.1),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.red),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                _showCancelDetails(context, tx);
                return false;
              }
              if (direction == DismissDirection.endToStart && !isCanceled) {
                await controller.cancelTransaction(tx.id!);
                // İşlemi iptal edince state güncellemesi yeterli
                tx.canceled = true;
                controller.allTransactions.refresh(); // anlık yenileme
              }
              return false; // asla silme
            },
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isCanceled
                      ? AppColors.inputBorder.withOpacity(0.1)
                      : isIncome
                      ? AppColors.success.withOpacity(
                          brightness == Brightness.light ? 0.1 : 0.25,
                        )
                      : AppColors.error.withOpacity(
                          brightness == Brightness.light ? 0.25 : 0.1,
                        ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isCanceled
                      ? Icons.cancel
                      : isIncome
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  size: 24,
                  color: isCanceled
                      ? AppColors.inputBorder
                      : isIncome
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
              title: Text(
                cat?.name ?? 'Kategori yok',
                style: isCanceled
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
              subtitle: Text(
                tx.description ?? "Açıklama yok",
                style: isCanceled
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isIncome ? '+' : '-'}'
                    '${NumberFormat.currency(symbol: '₺', decimalDigits: 2, locale: 'tr_TR').format(tx.amount ?? 0)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isIncome ? AppColors.success : AppColors.error,
                    ),
                  ),
                  Text(
                    DateFormat('dd MMMM y', 'tr_TR').format(tx.date!),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: brightness == Brightness.dark
                          ? AppColors.inputBorder
                          : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

void _showCancelDetails(BuildContext context, AppTransaction tx) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İşlem Detayı',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('ID: ${tx.id}'),
            Text(
              'Tutar: ${NumberFormat.currency(symbol: '₺', decimalDigits: 2, locale: 'tr_TR').format(tx.amount ?? 0)}',
            ),
            Text('Açıklama: ${tx.description ?? '-'}'),
            Text('Kategori: ${tx.category?.name ?? '-'}'),
            Text(
              'İşlem Tarihi: ${DateFormat('dd MMMM yyyy – HH:mm', 'tr_TR').format(tx.date!)}',
            ),
            const Divider(height: 24),
            Text(
              'İptal Bilgisi',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text('Kim iptal etti: ${tx.canceledBy ?? '-'}'),
            Text(
              'Ne zaman: ${tx.canceledAt != null ? DateFormat('dd MMMM yyyy – HH:mm', 'tr_TR').format(tx.canceledAt!) : '-'}',
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Kapat'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
