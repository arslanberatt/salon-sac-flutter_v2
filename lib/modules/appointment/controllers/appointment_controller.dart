import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/models/app_service.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/modules/transaction_dashboard/transaction_dashboard_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/appointment_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/service_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/user_repository.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class AppointmentController extends BaseController {
  final AppointmentRepository _appointmentRepository = Get.find();
  final UserRepository _userRepository = Get.find();
  final ServiceRepository _serviceRepository = Get.find();

  // Lists
  final employees = <AppUser>[].obs;
  final services = <AppService>[].obs;
  final appointments = <AppAppointment>[].obs;
  final filteredAppointments = <AppAppointment>[].obs;

  // Filters
  final selectedDate = DateTime.now().obs;
  final selectedEmployee = Rxn<AppUser>();
  final selectedServices = <AppService>[].obs;

  // Form
  final customerName = ''.obs;
  final customerPhone = ''.obs;
  final notes = ''.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    everAll([
      appointments,
      selectedDate,
      selectedEmployee,
      selectedServices,
    ], (_) => _applyFilters());
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    setLoading(true);
    try {
      final futures = await Future.wait([
        _userRepository.getActiveUsers(),
        _serviceRepository.getServices(),
        _appointmentRepository.getAppointments(),
      ]);
      employees.assignAll(futures[0] as List<AppUser>);
      services.assignAll(futures[1] as List<AppService>);
      appointments.assignAll(futures[2] as List<AppAppointment>);
      _applyFilters();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> refreshAppointments() async {
    await _loadAllAppointments();
  }

  Future<void> _loadAllAppointments() async {
    setLoading(true);
    try {
      final list = await _appointmentRepository.getAppointments();
      appointments.assignAll(list);
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  void _applyFilters() {
    final day = selectedDate.value;
    final wantEmp = selectedEmployee.value;
    final wantSvcIds = selectedServices.map((s) => s.id).toSet();

    filteredAppointments.value = appointments.where((a) {
      final st = a.startTime;
      if (st == null) return false;
      if (!(st.year == day.year && st.month == day.month && st.day == day.day))
        return false;
      if (wantEmp != null && a.employee?.id != wantEmp.id) return false;
      if (wantSvcIds.isNotEmpty) {
        final hasIds = a.services.map((s) => s.id).toSet();
        if (!wantSvcIds.every(hasIds.contains)) return false;
      }
      return true;
    }).toList();
  }

  void setDate(DateTime date) => selectedDate.value = date;
  void setEmployee(AppUser? emp) => selectedEmployee.value = emp;
  void toggleService(AppService svc) {
    selectedServices.contains(svc)
        ? selectedServices.remove(svc)
        : selectedServices.add(svc);
  }

  void clearForm() {
    selectedEmployee.value = null;
    customerName.value = '';
    customerPhone.value = '';
    selectedServices.clear();
    selectedDate.value = DateTime.now();
  }

  Future<void> createAppointment() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    formKey.currentState?.save();

    setLoading(true);
    try {
      final appt = AppAppointment(
        employee: selectedEmployee.value,
        customerName: customerName.value,
        customerPhone: customerPhone.value,
        services: selectedServices.toList(),
        startTime: selectedDate.value,
        isDone: false,
        isCancelled: false,
        price: selectedServices.fold<double>(
          0,
          (sum, s) => sum + (s.price ?? 0),
        ),
        notes: notes.value,
      );
      await _appointmentRepository.createAppointment(appt);
      await loadInitialData();
      clearForm();
      await loadInitialData();
      Get.back();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> markDone(String id) async {
    setLoading(true);
    try {
      await _appointmentRepository.markAsDone(id);
      await loadInitialData();
      Get.find<TransactionDashboardController>().refreshDashboard();
      Get.back();
      showSuccessSnackbar(message: 'Randevu onaylandı');
    } catch (e) {
      showErrorSnackbar(message: 'Tamamlama başarısız');
    } finally {
      setLoading(false);
    }
  }

  Future<void> cancel(String id) async {
    setLoading(true);
    try {
      await _appointmentRepository.cancel(id);
      await loadInitialData();
      Get.back(result: true);
      showSuccessSnackbar(message: 'Randevu iptal edildi');
    } catch (e) {
      showErrorSnackbar(message: 'İptal başarısız');
    } finally {
      setLoading(false);
    }
  }

  Future<void> goToUpdate(AppAppointment appt) async {
    final result = await Get.toNamed(
      AppRoutes.UPDATEAPPOINTMENT,
      arguments: appt,
    );
    if (result is AppAppointment) {
      final updated = getAppointmentById(result.id);
      if (updated != null) {
        Get.back(result: updated);
      }
    }
  }

  Future<void> confirmAndCancel(String id) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Onayla'),
        content: const Text(
          'Bu randevuyu iptal etmek istediğinize emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Vazgeç'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Evet'),
          ),
        ],
      ),
    );
    if (confirm == true) await cancel(id);
  }

  AppAppointment? getAppointmentById(String? id) {
    if (id == null) return null;
    return appointments.firstWhereOrNull((a) => a.id == id);
  }
}
