import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/models/app_service.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/repositories/appointment_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/service_repository.dart';
import 'package:salon_sac_flutter_v2/repositories/user_repository.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';

class AppointmentController extends BaseController {
  final AppointmentRepository _appointmentRepository =
      Get.find<AppointmentRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();

  // Data lists
  final employees = <AppUser>[].obs;
  final services = <AppService>[].obs;
  final appointments = <AppAppointment>[].obs;
  final filteredAppointments = <AppAppointment>[].obs;

  // Filter criteria
  final selectedDate = DateTime.now().obs;
  final selectedEmployee = Rxn<AppUser>();
  final selectedServices = <AppService>[].obs;

  // Form fields
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
      employees.assignAll(await _userRepository.getActiveUsers());
      services.assignAll(await _serviceRepository.getServices());
      await _loadAllAppointments();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  /// Loads all appointments
  Future<void> _loadAllAppointments() async {
    try {
      final list = await _appointmentRepository.getAppointments();
      appointments.assignAll(list);
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    }
  }

  /// Apply filters reactively
  void _applyFilters() {
    final day = selectedDate.value;
    final wantEmp = selectedEmployee.value;
    final wantSvcIds = selectedServices.map((s) => s.id).toSet();

    filteredAppointments.value = appointments.where((a) {
      final st = a.startTime;
      if (st == null) return false;
      // Date
      if (!(st.year == day.year && st.month == day.month && st.day == day.day))
        return false;
      // Not done/cancelled
      if (a.isDone == true || a.isCancelled == true) return false;
      // Employee
      if (wantEmp != null && a.employee?.id != wantEmp.id) return false;
      // Services
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
    if (selectedServices.contains(svc)) {
      selectedServices.remove(svc);
    } else {
      selectedServices.add(svc);
    }
  }

  void goToProfile() {
    Get.toNamed(AppRoutes.CALENDAR);
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
      Get.find<AppointmentController>().loadInitialData();
      Get.back();
      showSuccessSnackbar(message: 'Randevu oluşturuldu');
      clearForm();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      print(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> markDone(String id) async {
    setLoading(true);
    try {
      final updated = await _appointmentRepository.markAsDone(id);
      // örn: listeyi yenilemek için
      Get.find<AppointmentController>().loadInitialData();
      Get.back(result: updated);
      showSuccessSnackbar(message: 'Randevu tamamlandı');
    } catch (e) {
      showErrorSnackbar(message: 'Tamamlama başarısız');
    } finally {
      setLoading(false);
    }
  }

  Future<void> cancel(String id) async {
    setLoading(true);
    try {
      final updated = await _appointmentRepository.cancel(id);
      Get.find<AppointmentController>().loadInitialData();
      Get.back(result: updated);
      showSuccessSnackbar(message: 'Randevu iptal edildi');
    } catch (e) {
      showErrorSnackbar(message: 'İptal başarısız');
    } finally {
      setLoading(false);
    }
  }

  void clearForm() {
    selectedEmployee.value;
    customerName.value = '';
    customerPhone.value = '';
    selectedServices.value = [];
    selectedDate.value = DateTime.now();
  }
}
