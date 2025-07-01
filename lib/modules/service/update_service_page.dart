// update_service_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_service.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/update_service_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class UpdateServicePage extends GetView<UpdateServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hizmeti Düzenle')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hizmet Adı
              TextFormField(
                initialValue: controller.name.value,
                decoration: const InputDecoration(
                  labelText: 'Hizmet Adı',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => controller.name.value = v,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Boş olamaz' : null,
              ),
              const SizedBox(height: AppSizes.spacingM),
              TextFormField(
                initialValue: controller.duration.value.toString(),
                decoration: const InputDecoration(
                  labelText: 'Süre (dk)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) =>
                    controller.duration.value = int.tryParse(v) ?? 0,
                validator: (v) => v == null || v.isEmpty ? 'Boş olamaz' : null,
              ),
              const SizedBox(height: AppSizes.spacingM),
              TextFormField(
                initialValue: controller.price.value.toString(),
                decoration: const InputDecoration(
                  labelText: 'Fiyat (₺)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) =>
                    controller.price.value = double.tryParse(v) ?? 0.0,
                validator: (v) => v == null || v.isEmpty ? 'Boş olamaz' : null,
              ),
              const SizedBox(height: AppSizes.spacingL),

              ElevatedButton(
                onPressed: () async {
                  if (controller.formKey.currentState?.validate() ?? false) {
                    final updated = AppService(
                      id: controller.editingService!.id,
                      name: controller.name.value,
                      duration: controller.duration.value,
                      price: controller.price.value,
                    );
                    await controller.updateService(updated);
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
