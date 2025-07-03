import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/employe_list/employee_list_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class PassiveEmployeeList extends GetView<EmployeeListController> {
  const PassiveEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.passiveUsers.isEmpty) {
        return const Center(child: Text('Henüz bir pasif kullanıcı yok'));
      }
      return Obx(
        () => Container(
          child: ListView.separated(
            itemCount: controller.passiveUsers.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final service = controller.passiveUsers[index];
              return Dismissible(
                key: ValueKey(service.id),
                direction: DismissDirection.horizontal,
                background: Container(
                  color: Colors.blueGrey.withOpacity(0.1),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.info_outline, color: Colors.blueGrey),
                ),
                secondaryBackground: Container(
                  color: Colors.orange.withOpacity(0.1),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.edit, color: Colors.orange),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    Get.toNamed(AppRoutes.UPDATESERVICE, arguments: service);
                  }
                  return false;
                },
                child: ListTile(title: Text(service.name ?? '')),
              );
            },
          ),
        ),
      );
    });
  }
}
