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

      return RefreshIndicator(
        onRefresh: controller.getTransactions,
        color: AppColors.primaryDark,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView.separated(
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
                // ignore: deprecated_member_use
                color: Colors.blueGrey.withOpacity(0.1),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.info_outline, color: Colors.blueGrey),
              ),
              secondaryBackground: Container(
                // ignore: deprecated_member_use
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
                        // ignore: deprecated_member_use
                        ? AppColors.inputBorder.withOpacity(0.1)
                        : isIncome
                        // ignore: deprecated_member_use
                        ? AppColors.success.withOpacity(
                            brightness == Brightness.light ? 0.1 : 0.25,
                          )
                        // ignore: deprecated_member_use
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
        ),
      );
    });
  }
}

void _showCancelDetails(BuildContext context, AppTransaction tx) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  final textColor = isDark ? Colors.white : Colors.black87;
  final subColor = isDark ? Colors.white60 : Colors.black54;

  showModalBottomSheet(
    context: context,
    backgroundColor: theme.cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İşlem Detayı',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            _detailRow('ID', tx.id ?? '-', subColor),
            _detailRow(
              'Tutar',
              NumberFormat.currency(
                symbol: '₺',
                decimalDigits: 2,
                locale: 'tr_TR',
              ).format(tx.amount ?? 0),
              subColor,
            ),
            _detailRow('Açıklama', tx.description ?? '-', subColor),
            _detailRow('Kategori', tx.category?.name ?? '-', subColor),
            _detailRow(
              'İşlem Tarihi',
              DateFormat('dd MMMM yyyy – HH:mm', 'tr_TR').format(tx.date!),
              subColor,
            ),
            const Divider(height: 32),
            Text(
              'İptal Bilgisi',
              style: theme.textTheme.titleMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.red.shade100.withOpacity(0.1)
                    : Colors.red.shade50,
                border: Border.all(color: Colors.red.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'İptal edilen bir randevu ise çalışanın primi kadar olan tutar kesilmesi gerekir. Bu işlem sistem tarafından otomatik yapılmaz.',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? Colors.red.shade200
                            : Colors.red.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'İptal Bilgisi',
              style: theme.textTheme.titleMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _detailRow('İptal eden idsi', tx.canceledBy ?? '-', subColor),
            _detailRow(
              'Ne zaman',
              tx.canceledAt != null
                  ? DateFormat(
                      'dd MMMM yyyy – HH:mm',
                      'tr_TR',
                    ).format(tx.canceledAt!)
                  : '-',
              subColor,
            ),
          ],
        ),
      );
    },
  );
}

Widget _detailRow(String label, String value, Color valueColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        Expanded(
          child: Text(value, style: TextStyle(color: valueColor, fontSize: 14)),
        ),
      ],
    ),
  );
}
