import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/employe_list/employee_list_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class ActiveEmployeeList extends GetView<EmployeeListController> {
  const ActiveEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.activeUsers.isEmpty) {
        return const Center(child: Text('Henüz bir aktive kullanıcı yok'));
      }
      return Obx(
        () => ListView.separated(
          itemCount: controller.activeUsers.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final employee = controller.activeUsers[index];
            return Dismissible(
              key: ValueKey(employee.id),
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
                  Get.toNamed(
                    AppRoutes.EMPLOYEEMANAGEMENT,
                    arguments: employee,
                  );
                }
                if (direction == DismissDirection.startToEnd) {
                  Get.toNamed(
                    AppRoutes.EMPLOYEEMANAGEMENT,
                    arguments: employee,
                  );
                }
                return false;
              },
              child: ListTile(title: Text(employee.name ?? '')),
            );
          },
        ),
      );
    });
  }
}
