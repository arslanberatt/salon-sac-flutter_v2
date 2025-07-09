import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/employe_list/employee_list_controller.dart';
import 'package:salon_sac_flutter_v2/modules/employe_list/widgets/active_employee_list.dart';
import 'package:salon_sac_flutter_v2/modules/employe_list/widgets/passive_employee_list.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';

class EmployeeListPage extends GetView<EmployeeListController> {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Salon Saç',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightCard
                : AppColors.darkCard,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightCard
                : AppColors.darkCard,
            tabs: [
              Tab(text: 'Aktif'),
              Tab(text: 'Pasif'),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            children: [ActiveEmployeeList(), PassiveEmployeeList()],
          );
        }),
      ),
    );
  }
}
