import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_category.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';

class CategoryRepository extends GetxService {
  late final ApiServices _apiServices;

  @override
  void onInit() {
    super.onInit();
    _apiServices = Get.find<ApiServices>();
  }

  Future<List<AppCategory>> getCategories() async {
    final response = await _apiServices.get(ApiConstants.categories);

    if (response.statusCode == 200) {
      final list = (response.data['data'] ?? []) as List;
      return list.map((e) => AppCategory.fromJson(e)).toList();
    }
    throw Exception("Kategoriler getirilirken bir hata oluştu!");
  }

  Future<AppCategory> createCategory(AppCategory category) async {
    final response = await _apiServices.post(
      ApiConstants.createCategory,
      data: category.toJson(),
    );
    if (response.statusCode == 201) {
      return AppCategory.fromJson(response.data);
    }
    throw Exception("Kategoriler eklenirken bir hata oluştu!");
  }
}
