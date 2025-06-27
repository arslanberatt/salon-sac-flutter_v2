import 'package:get/instance_manager.dart';
import 'package:salon_sac_flutter_v2/modules/register/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
