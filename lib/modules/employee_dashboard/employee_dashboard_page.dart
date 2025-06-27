import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:salon_sac_flutter_v2/modules/employee_dashboard/employee_dashboard_controller.dart';

class EmployeeDashboardPage extends GetView<EmployeeDashboardController> {
  const EmployeeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salon Saç')),
      body: Center(child: Text('Çalışan Dashboard')),
    );
  }
}
