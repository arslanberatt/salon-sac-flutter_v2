import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/splash/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
