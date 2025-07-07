import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_advance.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';

class AdvanceRepository extends GetxService {
  late final ApiServices _apiServices;

  @override
  void onInit() {
    super.onInit();
    _apiServices = Get.find<ApiServices>();
  }

  Future<List<AppAdvance>> getAll() async {
    final res = await _apiServices.get(ApiConstants.allAdvanceRequests);
    if (res.statusCode == 200) {
      final data = res.data['data'] as List;
      print(data);
      return data.map((e) => AppAdvance.fromJson(e)).toList();
    }
    throw Exception("Avans verileri alınamadı");
  }

  Future<List<AppAdvance>> getMyAdvances() async {
    final res = await _apiServices.get(ApiConstants.myAdvanceRequests);
    print(res);
    if (res.statusCode == 200) {
      final data = res.data['data'] as List;
      print(data);
      return data.map((e) => AppAdvance.fromJson(e)).toList();
    }
    throw Exception("Kendi avans verilerin alınamadı");
  }

  Future<void> createAdvance(int amount, String reason) async {
    final res = await _apiServices.post(
      ApiConstants.createAdvanceRequest,
      data: {"amount": amount, "reason": reason},
    );
    if (res.statusCode != 201) {
      throw Exception("Avans talebi oluşturulamadı");
    }
  }

  Future<void> updateStatus(String id, String status) async {
    final res = await _apiServices.put(
      '${ApiConstants.theAdvanceRequest}/$id',
      data: {"status": status},
    );
    if (res.statusCode != 200) {
      throw Exception("Avans durumu güncellenemedi");
    }
  }
}
