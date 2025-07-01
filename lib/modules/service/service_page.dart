import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';
import 'package:salon_sac_flutter_v2/modules/service/widgets/duration_input.dart';
import 'package:salon_sac_flutter_v2/modules/service/widgets/name_input.dart';
import 'package:salon_sac_flutter_v2/modules/service/widgets/price_input.dart';
import 'package:salon_sac_flutter_v2/modules/service/widgets/service_button.dart';
import 'package:salon_sac_flutter_v2/modules/service/widgets/service_list.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class ServicePage extends GetView<ServiceController> {
  const ServicePage({super.key});

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
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SizedBox(height: AppSizes.spacingM),
                  NameInput(),
                  SizedBox(height: AppSizes.spacingM),
                  DurationInput(),
                  SizedBox(height: AppSizes.spacingM),
                  PriceInput(),
                  SizedBox(height: AppSizes.spacingM),
                  ServiceButton(),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spacingS),
            Expanded(child: ServiceList()),
          ],
        ),
      ),
    );
  }
}
