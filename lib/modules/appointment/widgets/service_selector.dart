import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_service.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class ServiceSelector extends GetView<AppointmentController> {
  const ServiceSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
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
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkCard
                    : AppColors.lightCard,
                selectedColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : AppColors.primary,
                labelStyle: TextStyle(
                  color: controller.selectedServices.contains(s)
                      ? AppColors.inputBorder
                      : AppColors.textSecondary,
                ),
                onSelected: (_) => controller.toggleService(s),
              ),
            );
          },
        ),
      ),
    );
  }
}
