import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_appointment.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';

class AppointmentRepository extends GetxService {
  late final ApiServices _apiServices;

  @override
  void onInit() {
    super.onInit();
    _apiServices = Get.find<ApiServices>();
  }

  Future<List<AppAppointment>> getAppointments() async {
    final response = await _apiServices.get(ApiConstants.appointments);
    if (response.statusCode == 200) {
      final raw = response.data['data'] as List<dynamic>? ?? [];
      final list = raw
          .map((e) => AppAppointment.fromJson(e as Map<String, dynamic>))
          .toList();
      list.sort((a, b) => a.startTime!.compareTo(b.startTime!));
      return list;
    }
    throw Exception('Randevular getirilirken hata: ${response.statusCode}');
  }

  Future<AppAppointment> createAppointment(AppAppointment appt) async {
    final response = await _apiServices.post(
      ApiConstants.createAppointment,
      data: appt.toJson(),
    );
    if (response.statusCode == 201) {
      return AppAppointment.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    }
    throw Exception('Randevu oluşturulurken hata oluştu!');
  }

  Future<AppAppointment> updateAppointment(AppAppointment appointment) async {
    final response = await _apiServices.put(
      '${ApiConstants.updateAppointments}/${appointment.id}',
      data: appointment.toJson(),
    );
    if (response.statusCode == 200) {
      return AppAppointment.fromJson(response.data);
    }
    throw Exception("Randevu güncellenirken bir hata oluştu!");
  }

  Future<AppAppointment> markAsDone(String id) async {
    final res = await _apiServices.put('${ApiConstants.markAsDone}/$id');
    if (res.statusCode == 200) {
      return AppAppointment.fromJson(res.data['data']);
    }
    throw Exception('Randevu işaretlenirken hata oluştu');
  }

  Future<AppAppointment> cancel(String id) async {
    final res = await _apiServices.put('${ApiConstants.cancelAppointment}/$id');
    if (res.statusCode == 200) {
      return AppAppointment.fromJson(res.data['data']);
    }
    throw Exception('Randevu iptal edilirken hata oluştu');
  }
}
