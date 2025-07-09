import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_salary.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';

class SalaryRepository extends GetxService {
  late final ApiServices _apiServices;

  @override
  void onInit() {
    super.onInit();
    _apiServices = Get.find<ApiServices>();
  }

  Future<List<AppSalary>> getSalaries() async {
    final response = await _apiServices.get(ApiConstants.allSalaryRecords);

    if (response.statusCode == 200) {
      final list = (response.data['data'] ?? []) as List;
      return list.map((e) => AppSalary.fromJson(e)).toList();
    }
    throw Exception("Maaşlar getirilirken bir hata oluştu!");
  }

  Future<List<AppSalary>> getMySalaries() async {
    final response = await _apiServices.get(ApiConstants.mySalaryRecords);

    if (response.statusCode == 200) {
      final list = response.data['data'] as List;
      return list.map((e) => AppSalary.fromJson(e)).toList();
    }
    throw Exception("Maaşlar getirilirken bir hata oluştu!");
  }
}
