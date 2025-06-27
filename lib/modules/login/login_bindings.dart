import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/login/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
