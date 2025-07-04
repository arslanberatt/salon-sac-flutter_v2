import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/update_appointment_controller.dart';
import 'package:salon_sac_flutter_v2/modules/splash/splash_controller.dart';
import 'package:salon_sac_flutter_v2/modules/profile/profile_controller.dart';
import 'package:salon_sac_flutter_v2/modules/service/controllers/service_controller.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_controller.dart';
import 'package:salon_sac_flutter_v2/modules/support/support_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.lazyPut<AppointmentController>(
      () => AppointmentController(),
      fenix: true,
    );
    Get.lazyPut<UpdateAppointmentController>(
      () => UpdateAppointmentController(),
      fenix: true,
    );
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<SupportController>(() => SupportController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<ServiceController>(() => ServiceController(), fenix: true);
  }
}
