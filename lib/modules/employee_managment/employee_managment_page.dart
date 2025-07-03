// update_user_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/modules/employee_managment/employee_management_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class EmployeeManagmentPage extends GetView<EmployeeManagementController> {
  const EmployeeManagmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: controller.salary.value.toString(),
                decoration: const InputDecoration(
                  labelText: 'Maaş (₺)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    controller.salary.value = int.tryParse(value) ?? 0,
              ),
              const SizedBox(height: AppSizes.spacingM),
              TextFormField(
                initialValue: controller.commissionRate.value.toString(),
                decoration: const InputDecoration(
                  labelText: 'Komisyon (%)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    controller.commissionRate.value = int.tryParse(value) ?? 0,
              ),
              const SizedBox(height: AppSizes.spacingM),

              Obx(
                () => SwitchListTile(
                  title: const Text('Moderatör'),
                  value: controller.isMod.value,
                  onChanged: (value) => controller.isMod.value = value,
                  activeColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSizes.spacingM),
              Obx(
                () => SwitchListTile(
                  title: const Text('Aktif'),
                  value: controller.isActive.value,
                  onChanged: (value) => controller.isActive.value = value,
                  activeColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSizes.spacingM),
              Obx(
                () => SwitchListTile(
                  title: const Text('Admin'),
                  value: controller.isAdmin.value,
                  onChanged: (value) => controller.isAdmin.value = value,
                  activeColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSizes.spacingL),
              ElevatedButton(
                onPressed: () async {
                  if (controller.formKey.currentState?.validate() ?? false) {
                    final updated = AppUser(
                      id: controller.editingUser!.id,
                      salary: controller.salary.value,
                      commissionRate: controller.commissionRate.value,
                      isMod: controller.isMod.value,
                      isActive: controller.isActive.value,
                      isAdmin: controller.isAdmin.value,
                    );
                    await controller.updateEmployee(updated);
                  }
                },
                child: const Text('Güncelle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
