import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';

class UserRepository extends GetxService {
  late final ApiServices _apiServices;

  @override
  void onInit() {
    super.onInit();
    _apiServices = Get.find<ApiServices>();
  }

  Future<AppUser?> updateProfile({
    required Map<String, dynamic> body,
    XFile? avatarFile,
  }) async {
    final form = FormData();
    body.forEach((k, v) {
      form.fields.add(MapEntry(k, v.toString()));
    });
    if (avatarFile != null) {
      form.files.add(
        MapEntry(
          'avatar',
          await MultipartFile.fromFile(
            avatarFile.path,
            filename: avatarFile.name,
          ),
        ),
      );
    }

    try {
      final res = await _apiServices.put(
        ApiConstants.updateProfile,
        data: form,
        options: Options(
          contentType: 'multipart/form-data',
          validateStatus: (status) => status != null && status < 600,
        ),
      );
      if (res.statusCode == 200 && res.data['data'] != null) {
        return AppUser.fromJson(res.data['data']);
      } else {
        print('Profil güncelleme başarısız: ${res.statusCode} → ${res.data}');
      }
    } on DioException catch (e) {
      print('DioException güncelleme sırasında: $e');
    }
    return null;
  }
}
