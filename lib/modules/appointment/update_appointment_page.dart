import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/update_appointment_controller.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/new_appointment_date.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class UpdateAppointmentPage extends GetView<UpdateAppointmentController> {
  const UpdateAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Randevuyu Güncelle',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: controller.customerName.value,
                  decoration: const InputDecoration(labelText: 'Müşteri Adı'),
                  onChanged: (v) => controller.customerName.value = v,
                  validator: (v) => v == null || v.isEmpty
                      ? 'Lütfen müşteri adı giriniz!'
                      : null,
                ),
                const SizedBox(height: AppSizes.spacingM),
                TextFormField(
                  initialValue: controller.customerPhone.value,
                  decoration: const InputDecoration(
                    labelText: 'Müşteri Telefon',
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => controller.customerPhone.value = v,
                  validator: (v) => v == null || v.isEmpty
                      ? 'Lütfen müşteri telefonu giriniz!'
                      : null,
                ),
                const SizedBox(height: AppSizes.spacingM),
                TextFormField(
                  initialValue: controller.notes.value,
                  decoration: const InputDecoration(labelText: 'Notlar'),
                  onChanged: (v) => controller.notes.value = v,
                ),
                const SizedBox(height: AppSizes.spacingM),
                TextFormField(
                  initialValue: controller.price.value.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Fiyat'),
                  onChanged: (v) =>
                      controller.price.value = double.tryParse(v) ?? 0.0,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Fiyat giriniz' : null,
                ),

                const SizedBox(height: AppSizes.spacingS),
                NewAppointmentDate(
                  initialDate: controller.startTime,
                  onDateSelected: (picked) {
                    controller.startTime = picked;
                  },
                ),
                const SizedBox(height: AppSizes.spacingL),

                ElevatedButton(
                  onPressed: () async {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      await controller.saveUpdatedAppointment();
                    }
                  },
                  child: const Text('Güncelle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
