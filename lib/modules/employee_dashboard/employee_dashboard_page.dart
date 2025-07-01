import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/section_title.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class EmployeeDashboardPage extends StatelessWidget {
  EmployeeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final progressValue = 30.0;

    return Scaffold(
      appBar: AppBar(title: Text('Salon Saç')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
                  PrimSistem(progressValue: progressValue),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SectionTitle(
                  title: "Kategoriler",
                  subtitle: "Günlük planlar ve randevular",
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _categoryCard("Personal Plan", 3)),
                const SizedBox(width: 12),
                Expanded(child: _categoryCard("Work Plan", 8)),
              ],
            ),

            const SizedBox(height: 24),

            // Ongoing Plan
            SectionTitle(title: "Randevular", subtitle: "Bugün ki randevular"),
            _ongoingCard(),
            const SizedBox(height: 12),
            _ongoingCard(
              title: "Workout",
              tasks: ["Stretching", "Yoga Session"],
            ),
          ],
        ),
      ),
    );
  }
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

Widget _categoryCard(String title, int plans) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        const Icon(Icons.calendar_today_outlined),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          "$plans Plans Remaining",
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Go to Plan", style: TextStyle(color: Colors.indigo)),
            Icon(Icons.arrow_forward_ios, size: 12, color: Colors.indigo),
          ],
        ),
      ],
    ),
  );
}

Widget _ongoingCard({
  String title = "Creating webflow design and\nresponsive on mobile",
  List<String>? tasks,
}) {
  final taskList = tasks ?? ["Create Lo-Fi", "Create Landing Page"];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...taskList.map(
          (task) => Row(
            children: [
              const Icon(Icons.check_circle, size: 18, color: Colors.green),
              const SizedBox(width: 8),
              Text(task),
            ],
          ),
        ),
      ],
    ),
  );
}
