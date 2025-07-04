import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/repositories/appointment_repository.dart';

class EmployeeHistoryController extends BaseController {
  final appointmentRepo = Get.find<AppointmentRepository>();
  late AppUser employee;
  final appointments = <AppAppointment>[].obs;

  @override
  void onInit() {
    super.onInit();
    employee = Get.arguments as AppUser;
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    setLoading(true);
    try {
      final all = await appointmentRepo.getAppointments();
      appointments.value = all
          .where((a) => a.employee?.id == employee.id)
          .toList();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }
}
