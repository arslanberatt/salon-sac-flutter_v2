import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/modules/advance/advance_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AdvancePage extends GetView<AdvanceController> {
  const AdvancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              Tab(text: 'Tümü'),
              Tab(text: 'Onaylanan'),
              Tab(text: 'Reddedilen'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => _buildAdvanceList(controller.allRequests)),
            Obx(() => _buildAdvanceList(controller.approved)),
            Obx(() => _buildAdvanceList(controller.rejected)),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvanceList(List list) {
    if (list.isEmpty) {
      return const Center(child: Text('Gösterilecek kayıt yok.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSizes.spacingS),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = list[index];
        final date = DateFormat(
          'dd MMM yyyy - HH:mm',
          'tr_TR',
        ).format(item.createdAt!);
        final statusColor = item.status == 'onaylandi'
            ? Colors.green
            : item.status == 'reddedildi'
            ? Colors.red
            : Colors.orange;
        final employeeName = item.employee?.name != null
            ? '${item.employee!.name} ${item.employee!.lastname}'
            : 'Çalışan';

        return Dismissible(
          key: ValueKey(item.id),
          direction: item.status == 'beklemede'
              ? DismissDirection.horizontal
              : DismissDirection.none,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.close, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.green,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.check, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              await controller.updateStatus(item.id!, 'onaylandi');
            } else if (direction == DismissDirection.startToEnd) {
              await controller.updateStatus(item.id!, 'reddedildi');
            }
            return false;
          },
          child: ListTile(
            title: Text('$employeeName - ${item.amount} ₺'),
            subtitle: Text('${item.reason}\n$date'),
            isThreeLine: true,
            trailing: Text(
              item.status!.toUpperCase(),
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
