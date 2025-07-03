import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/appointment_date.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/appointment_save_button.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/employee_dropdown.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/service_selector.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AppointmentPage extends GetView<AppointmentController> {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(AppSizes.paddingM),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EmployeeDropdown(),
              SizedBox(height: AppSizes.spacingM),
              Text('Hizmetler', style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: AppSizes.spacingS),
              ServiceSelector(),
              SizedBox(height: AppSizes.spacingM),
              TextFormField(
                decoration: InputDecoration(labelText: 'Müşteri Adı'),
                onSaved: (v) => controller.customerName.value = v ?? '',
                validator: (v) => v == null || v.isEmpty
                    ? 'Lütfen müşteri adı giriniz!'
                    : null,
              ),
              SizedBox(height: AppSizes.spacingM),
              TextFormField(
                decoration: InputDecoration(labelText: 'Müşteri Telefon'),
                keyboardType: TextInputType.phone,
                onSaved: (v) => controller.customerPhone.value = v ?? '',
                validator: (v) => v == null || v.isEmpty
                    ? 'Lütfen müşteri telefonu giriniz!'
                    : null,
              ),
              SizedBox(height: AppSizes.spacingM),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notlar'),
                onSaved: (v) => controller.notes.value = v ?? '',
              ),
              SizedBox(height: AppSizes.spacingS),
              AppointmentDate(),
              SizedBox(height: AppSizes.spacingS),
              AppointmentSaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
