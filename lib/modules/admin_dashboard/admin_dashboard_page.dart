import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/admin_dashboard/admin_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/custom_appbar.dart';
import 'package:salon_sac_flutter_v2/modules/common_widgets/section_title.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AdminDashboardPage extends GetView<AdminDashboardController> {
  AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusM),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Kasa",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: AppSizes.spacingS),
                        Row(
                          children: [
                            Text(
                              '23.250,00 ₺',
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
                    Icon(Icons.people_alt_outlined),
                    "Çalışanlar",
                    3,
                    () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _categoryCard(
                    context,
                    Icon(Icons.cut_outlined),

                    "Hizmetler",
                    8,
                    controller.goToService,
                  ),
                ),
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

Widget _categoryCard(
  BuildContext context,
  Icon icon,
  String title,
  int plans,
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
          Text("$plans adet", style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
        ],
      ),
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
