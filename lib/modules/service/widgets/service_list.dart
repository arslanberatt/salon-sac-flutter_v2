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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:salon_sac_flutter_v2/models/app_service.dart';
// import 'package:salon_sac_flutter_v2/modules/service/service_controller.dart';
// import 'package:salon_sac_flutter_v2/routes/app_routes.dart';

// class ServiceList extends GetView<ServiceController> {
//   const ServiceList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final services = controller.services;
//       if (services.isEmpty) {
//         return const Center(child: Text('Henüz bir hizmet yok'));
//       }
//       return ListView.separated(
//         itemCount: services.length,
//         separatorBuilder: (_, __) => const Divider(height: 1),
//         itemBuilder: (context, index) {
//           final service = services[index];
//           return Dismissible(
//             key: ValueKey(service.id),
//             direction: DismissDirection.endToStart,
//             background: Container(), // boş bırak, sadece edit için secondaryBackground kullan
//             secondaryBackground: Container(
//               color: Colors.orange.withOpacity(0.1),
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: const Icon(Icons.edit, color: Colors.orange),
//             ),
//             confirmDismiss: (direction) async {
//               if (direction == DismissDirection.endToStart) {
//                 // Düzenleme sayfasına git
//                 Get.toNamed(
//                   AppRoutes.UPDATE_SERVICE,
//                   arguments: service,
//                 )?.then((_) => controller.getServices());
//               }
//               return false;
//             },
//             child: ListTile(
//               title: Text(service.name ?? ''),
//               subtitle: Text('${service.duration} dk · ₺${service.price}'),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
