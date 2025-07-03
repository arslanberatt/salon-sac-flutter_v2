import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class ServiceList extends GetView<ServiceController> {
  const ServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.allServices.isEmpty) {
        return const Center(child: Text('Henüz bir işlem yok'));
      }
      return Obx(
        () => Container(
          child: ListView.separated(
            itemCount: controller.allServices.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final service = controller.allServices[index];
              return Dismissible(
                key: ValueKey(service.id),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.blueGrey.withOpacity(0.1),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.blueGrey,
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    Get.toNamed(AppRoutes.UPDATESERVICE, arguments: service);
                  }
                  return false;
                },
                child: ListTile(
                  title: Text(service.name ?? ''),
                  subtitle: Text('${service.duration} dk · ₺${service.price}'),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
