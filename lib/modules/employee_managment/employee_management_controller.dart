import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/modules/employe_list/employee_list_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/user_repository.dart';

class EmployeeManagementController extends BaseController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final formKey = GlobalKey<FormState>();
  final isAdmin = false.obs;
  final isActive = false.obs;
  final isMod = false.obs;
  final salary = 0.obs;
  final commissionRate = 0.obs;
  final allActiveUsers = <AppUser>[].obs;

  AppUser? editingUser;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is AppUser) {
      editingUser = arg;
      isAdmin.value = arg.isAdmin ?? false;
      isActive.value = arg.isActive ?? false;
      isMod.value = arg.isMod ?? false;
      salary.value = arg.salary ?? 0;
      commissionRate.value = arg.commissionRate ?? 0;
    }
  }

  Future<void> updateEmployee(AppUser employee) async {
    setLoading(true);
    try {
      await _userRepository.updateUser(employee);
      await Future.wait([
        Get.find<EmployeeListController>().loadActiveUsers(),
        Get.find<EmployeeListController>().loadPassiveUsers(),
      ]);
      Get.back();
      showSuccessSnackbar(message: 'Kullanıcı başarıyla güncellendi');
    } catch (e) {
      showErrorSnackbar(message: 'Kullanıcı güncellenirken hata oluştu');
    } finally {
      setLoading(false);
    }
  }
}
