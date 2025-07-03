import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/repositories/user_repository.dart';

class EmployeeListController extends BaseController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final activeUsers = <AppUser>[].obs;
  final passiveUsers = <AppUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadActiveUsers();
    loadPassiveUsers();
  }

  Future<void> refreshUsers() async {
    await activeUsers();
  }

  Future<void> loadActiveUsers() async {
    setLoading(true);
    try {
      activeUsers.value = await _userRepository.getActiveUsers();
    } catch (e) {
      showErrorSnackbar(message: 'Aktif kullanıcılar yüklenirken hata oluştu');
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadPassiveUsers() async {
    setLoading(true);
    try {
      passiveUsers.value = await _userRepository.getPassiveUsers();
    } catch (e) {
      showErrorSnackbar(message: 'Aktif kullanıcılar yüklenirken hata oluştu');
    } finally {
      setLoading(false);
    }
  }
}
