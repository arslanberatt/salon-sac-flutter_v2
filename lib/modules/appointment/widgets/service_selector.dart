import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_service.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class ServiceSelector extends GetView<AppointmentController> {
  const ServiceSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.services.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final AppService s = controller.services[i];
          return Obx(
            () => ChoiceChip(
              label: Text(s.name ?? ''),
              selected: controller.selectedServices.contains(s),
              showCheckmark: true,
              checkmarkColor: Colors.white,
              backgroundColor: AppColors.lightCard,
              selectedColor: AppColors.primaryDark,
              labelStyle: TextStyle(
                color: controller.selectedServices.contains(s)
                    ? Colors.white
                    : null,
              ),
              onSelected: (_) => controller.toggleService(s),
            ),
          );
        },
      ),
    );
  }
}
