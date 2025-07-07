import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_salary.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/repositories/appointment_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/salary_repository.dart';

class EmployeeHistoryController extends BaseController {
  final appointmentRepo = Get.find<AppointmentRepository>();
  final SalaryRepository _salaryRepository = Get.find<SalaryRepository>();
  late AppUser employee;
  final appointments = <AppAppointment>[].obs;
  final salaryRecords = <AppSalary>[].obs;

  final DateTime selectedMonth = DateTime(2025, 7); // Örnek: Temmuz 2025

  @override
  void onInit() {
    super.onInit();
    employee = Get.arguments as AppUser;
    fetchAppointments();
    fetchSalaries();
  }

  Future<void> fetchAppointments() async {
    setLoading(true);
    try {
      final all = await appointmentRepo.getAppointments();
      appointments.value = all.where((a) {
        return a.employee?.id == employee.id &&
            a.startTime != null &&
            a.startTime!.year == selectedMonth.year &&
            a.startTime!.month == selectedMonth.month;
      }).toList();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchSalaries() async {
    try {
      final all = await _salaryRepository.getSalaries();
      salaryRecords.value = all.where((r) {
        return r.employeeId?.id == employee.id &&
            r.date != null &&
            r.date!.year == selectedMonth.year &&
            r.date!.month == selectedMonth.month;
      }).toList();
    } catch (e) {
      showErrorSnackbar(message: 'Gelirler yüklenemedi');
    }
  }
}
