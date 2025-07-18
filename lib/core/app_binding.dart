import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/repositories/advance_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/appointment_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/category_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/salary_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/service_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/transaction_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/user_repository.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';
import 'package:salon_sac_flutter_v2/services/storage_service.dart';
import 'package:salon_sac_flutter_v2/services/theme_service.dart';

class AppBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<StorageService>(() async {
      final service = StorageService();
      await service.init();
      return service;
    }, permanent: true);

    Get.put(ThemeService());

    await Get.putAsync<ApiServices>(() async {
      final service = ApiServices();
      await service.init();
      return service;
    });

    await Get.putAsync<AuthService>(() async {
      final service = AuthService();
      await service.init();
      return service;
    });

    Get.put(CategoryRepository());
    Get.put(TransactionRepository());
    Get.put(UserRepository());
    Get.put(ServiceRepository());
    Get.put(AppointmentRepository());
    Get.put(SalaryRepository());
    Get.put(AdvanceRepository());
  }
}
