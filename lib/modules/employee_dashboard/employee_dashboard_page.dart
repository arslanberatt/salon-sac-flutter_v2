import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/widgets/today_appointments.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/section_title.dart';
import 'package:salon_sac_flutter_v2/modules/employee/employee_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/employee_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class EmployeeDashboardPage extends GetView<EmployeeDashboardController> {
  const EmployeeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
          child: Text(
            'Salon Saç',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        centerTitle: false,
        actionsPadding: EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
        actions: [
          IconButton(
            onPressed: () => Get.find<EmployeeController>().goToAppointment(),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(16, 32, 56, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hesap Tutarı",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              '3.250,00 ₺',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PrimSistem(progressValue: 30),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spacingXL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SectionTitle(
                  title: "Kategoriler",
                  subtitle: "Günlük planlar ve randevular",
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _categoryCard(
                    context,
                    Icon(Icons.list),
                    "Takvim",
                    controller.goToCalendar,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _categoryCard(
                    context,
                    Icon(Icons.request_page_outlined),
                    "Avans",
                    controller.goToAdvanceRequest,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Ongoing Plan
            SectionTitle(title: "Randevular", subtitle: "Bugün ki randevular"),
            TodaysAppointmentsList(),
          ],
        ),
      ),
    );
  }
}

Widget _categoryCard(
  BuildContext context,
  Icon icon,
  String title,
  Callback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
      ),
      child: Column(
        children: [
          icon,
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 4),
        ],
      ),
    ),
  );
}

class PrimSistem extends StatelessWidget {
  const PrimSistem({super.key, required this.progressValue});
  final double progressValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: SfRadialGauge(
        animationDuration: 2000,
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: AppColors.textSecondary,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
                color: Colors.white,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  '${progressValue.toStringAsFixed(0)} / 100',
                  style: TextStyle(color: AppColors.textWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
