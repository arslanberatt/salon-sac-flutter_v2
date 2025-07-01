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
      if (controller.allTransactions.isEmpty) {
        return Center(child: Text('Henüz bir işlem yok'));
      }
      return Container(
        child: ListView.separated(
          itemBuilder: (context, index) {
            var theTransaction = controller.allTransactions[index];
            var category = theTransaction.category;
            return Dismissible(
              key: ValueKey(theTransaction.id),
              direction: theTransaction.canceled == true
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
                  _showCancelDetails(context, theTransaction);
                  return false; // listeden kaldırma
                }
                if (direction == DismissDirection.endToStart &&
                    theTransaction.canceled == false) {
                  controller.cancelTransaction(theTransaction.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('İşlem iptal edildi'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                return false;
              },
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theTransaction.canceled == true
                        ? AppColors.inputBorder.withOpacity(0.1)
                        : theTransaction.category?.type == 'gelir'
                        ? (Theme.of(context).brightness == Brightness.light
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.success.withOpacity(0.25))
                        : (Theme.of(context).brightness == Brightness.dark
                              ? AppColors.error.withOpacity(0.1)
                              : AppColors.error.withOpacity(0.25)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    theTransaction.canceled == true
                        ? Icons.cancel
                        : theTransaction.category?.type == 'gelir'
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    size: 24,
                    color: theTransaction.canceled == true
                        ? AppColors.inputBorder
                        : theTransaction.category?.type == 'gelir'
                        ? AppColors.success
                        : AppColors.error,
                  ),
                ),
                title: Text(
                  category?.name ?? 'Açıklama yok',
                  style: theTransaction.canceled == true
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                ),
                subtitle: Text(
                  theTransaction.description ?? "Açıklama yok",
                  style: theTransaction.canceled == true
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${theTransaction.category?.type == 'gelir' ? '+' : '-'}'
                      '${NumberFormat.currency(symbol: '₺', decimalDigits: 2, locale: 'tr_TR').format(double.parse(theTransaction.amount?.toString() ?? '0'))}',
                      style: TextStyle(
                        fontSize: 14,
                        color: theTransaction.category?.type == 'gelir'
                            ? (Theme.of(context).brightness == Brightness.light)
                                  ? AppColors.success
                                  : AppColors.success
                            : (Theme.of(context).brightness == Brightness.dark)
                            ? AppColors.error
                            : AppColors.error,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMMM y').format(theTransaction.date!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.inputBorder
                            : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 1);
          },
          itemCount: controller.allTransactions.length,
        ),
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
