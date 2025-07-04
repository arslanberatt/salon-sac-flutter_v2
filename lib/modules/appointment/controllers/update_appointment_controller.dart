import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/modules/appointment/controllers/appointment_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/appointment_repository.dart';

class UpdateAppointmentController extends BaseController {
  final AppointmentRepository _appointmentRepository =
      Get.find<AppointmentRepository>();
  final formKey = GlobalKey<FormState>();

  final customerName = ''.obs;
  final customerPhone = ''.obs;
  final notes = ''.obs;
  final price = 0.0.obs;
  DateTime? startTime;

  AppAppointment? editingAppointment;

  @override
  void onInit() {
    super.onInit();
    Get.find<AppointmentController>().refreshAppointments();
    final arg = Get.arguments;
    if (arg is AppAppointment) {
      editingAppointment = arg;
      customerName.value = arg.customerName ?? '';
      customerPhone.value = arg.customerPhone ?? '';
      notes.value = arg.notes ?? '';
      price.value = arg.price ?? 0.0;
    }
  }

  Future<void> saveUpdatedAppointment() async {
    if (editingAppointment == null) return;
    if (formKey.currentState?.validate() != true) return;

    final updated = AppAppointment(
      id: editingAppointment!.id,
      customerName: customerName.value,
      customerPhone: customerPhone.value,
      notes: notes.value,
      price: price.value,
      startTime: startTime ?? editingAppointment!.startTime,
      services: editingAppointment!.services,
    );
    await updateAppointment(updated);
  }

  Future<void> updateAppointment(AppAppointment appointment) async {
    setLoading(true);
    try {
      await _appointmentRepository.updateAppointment(appointment);
      Get.find<AppointmentController>().refreshAppointments();
      Get.back();
      showSuccessSnackbar(message: 'Randevu güncellendi');
    } catch (e) {
      showErrorSnackbar(message: 'Randevu güncellenirken hata oluştu');
    } finally {
      setLoading(false);
    }
  }

  
}
