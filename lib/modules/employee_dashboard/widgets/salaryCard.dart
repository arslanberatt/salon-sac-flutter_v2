import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/controllers/balance_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SalaryCard extends GetView<BalanceController> {
  const SalaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '₺', locale: 'tr_TR');
    return Obx(
      () => Column(
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
                        "Cüzdan",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        currency.format(controller.netBalance),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                PrimSistem(progressValue: controller.percentage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrimSistem extends StatelessWidget {
  const PrimSistem({super.key, required this.progressValue});
  final double progressValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
