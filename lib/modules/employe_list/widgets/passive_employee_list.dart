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
        return const Center(child: Text('Henüz bir aktive kullanıcı yok'));
      }
      return Obx(
        () => ListView.separated(
          itemCount: controller.passiveUsers.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final employee = controller.passiveUsers[index];
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
                  Get.toNamed(AppRoutes.EMPLOYEEHISTORY, arguments: employee);
                }
                if (direction == DismissDirection.endToStart) {
                  Get.toNamed(
                    AppRoutes.EMPLOYEEMANAGEMENT,
                    arguments: employee,
                  );
                }
                return false;
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: employee.avatar != null
                      ? NetworkImage(employee.avatar!)
                      : null,
                  child: employee.avatar == null
                      ? Icon(Icons.person, size: 12, color: Colors.white)
                      : null,
                ),
                title: Text(
                  '${employee.name ?? ''} ${employee.lastname ?? ''}',
                ),
                subtitle: Text(employee.phone ?? '-'),
              ),
            );
          },
        ),
      );
    });
  }
}
