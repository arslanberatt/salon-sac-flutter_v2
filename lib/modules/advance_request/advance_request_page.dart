import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/advance_request/advance_request_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AdvanceRequestPage extends GetView<AdvanceRequestController> {
  const AdvanceRequestPage({super.key});

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
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Tutar"),
                    keyboardType: TextInputType.number,
                    onSaved: (val) =>
                        controller.amount.value = int.tryParse(val ?? '') ?? 0,
                    validator: (val) =>
                        (val == null || val.isEmpty) ? "Zorunlu" : null,
                  ),
                  const SizedBox(height: AppSizes.spacingM),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Açıklama"),
                    onSaved: (val) => controller.reason.value = val ?? '',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? "Zorunlu" : null,
                  ),
                  const SizedBox(height: AppSizes.spacingM),
                  ElevatedButton(
                    onPressed: controller.submit,
                    child: const Text("Talep Gönder"),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Obx(() {
                final list = controller.myRequests;
                if (list.isEmpty) {
                  return const Center(child: Text("Henüz talebiniz yok."));
                }
                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: AppSizes.spacingS),
                  itemBuilder: (_, i) {
                    final r = list[i];
                    return ListTile(
                      title: Text('${r.amount} ₺ - ${r.status ?? ''}'),
                      subtitle: Text(r.reason.toString()),
                      trailing: Text(
                        r.createdAt != null
                            ? r.createdAt!.toLocal().toString().split('.').first
                            : '',
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
