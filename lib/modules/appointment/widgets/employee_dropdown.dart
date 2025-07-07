import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class EmployeeDropdown extends GetView<AppointmentController> {
  const EmployeeDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownMenu<AppUser>(
        width: MediaQuery.of(context).size.width - AppSizes.paddingXL,
        menuHeight: 240,
        hintText: 'Çalışan Seç',
        initialSelection: controller.selectedEmployee.value,
        onSelected: (AppUser? user) {
          controller.setEmployee(user);
        },
        dropdownMenuEntries: controller.employees
            .map(
              (AppUser u) =>
                  DropdownMenuEntry(value: u, label: '${u.name} ${u.lastname}'),
            )
            .toList(),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.textWhite),
          elevation: WidgetStatePropertyAll(8),
          shadowColor: WidgetStatePropertyAll(Colors.black26),
          padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(vertical: 8),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
              side: BorderSide(color: AppColors.inputBorder, width: 1.5),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusS),
          ),
        ),
      );
    });
  }
}
