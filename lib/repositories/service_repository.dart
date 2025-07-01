import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_service.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';

class ServiceRepository extends GetxService {
  late final ApiServices _apiServices;

  @override
  void onInit() {
    super.onInit();
    _apiServices = Get.find<ApiServices>();
  }

  Future<List<AppService>> getServices() async {
    final response = await _apiServices.get(ApiConstants.services);

    if (response.statusCode == 200) {
      final list = (response.data['data'] ?? []) as List;
      print(list);
      print(list.map((e) => AppService.fromJson(e)).toList());
      return list.map((e) => AppService.fromJson(e)).toList();
    }
    throw Exception("Kategoriler getirilirken bir hata oluştu!");
  }

  Future<AppService> createService(AppService service) async {
    final response = await _apiServices.post(
      ApiConstants.createService,
      data: service.toJson(),
    );
    if (response.statusCode == 201) {
      return AppService.fromJson(response.data);
    }
    throw ("Kategoriler eklenirken bir hata oluştu!");
  }

  Future<AppService> updateService(AppService service) async {
    final response = await _apiServices.put(
      '${ApiConstants.updateService}/${service.id}',
      data: service.toJson(),
    );
    if (response.statusCode == 200) {
      return AppService.fromJson(response.data);
    }
    throw Exception("Servis güncellenirken bir hata oluştu!");
  }
}
