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

  Future<AppUser?> changePassword(String password) async {
    final resp = await _apiServices.put(
      ApiConstants.updateProfile,
      data: {'password': password},
    );
    if (resp.statusCode == 200) {
      return AppUser.fromJson(resp.data['data']);
    }
    return null;
  }

  Future<List<AppUser>> getActiveUsers() async {
    final response = await _apiServices.get(ApiConstants.activeUsers);

    if (response.statusCode == 200) {
      final list = (response.data['data'] ?? []) as List;
      return list.map((e) => AppUser.fromJson(e)).toList();
    }
    throw Exception("Kullanıcılar getirilirken bir hata oluştu!");
  }

  Future<List<AppUser>> getPassiveUsers() async {
    final response = await _apiServices.get(ApiConstants.passiveUsers);

    if (response.statusCode == 200) {
      final list = (response.data['data'] ?? []) as List;
      return list.map((e) => AppUser.fromJson(e)).toList();
    }
    throw Exception("Kullanıcılar getirilirken bir hata oluştu!");
  }

  Future<AppUser> updateUser(AppUser employee) async {
    final response = await _apiServices.put(
      '${ApiConstants.updateUser}/${employee.id}',
      data: employee.toJson(),
    );
    if (response.statusCode == 200) {
      final user = AppUser.fromJson(response.data['data'] ?? response.data);
      return user;
    }
    throw Exception("Kullanıcı güncellenirken bir hata oluştu!");
  }

  Future<bool> forgetPassword(String email) async {
    try {
      final res = await _apiServices.post(
        ApiConstants.forgotPassword,
        data: {'email': email},
      );
      return res.statusCode == 200;
    } catch (e) {
      print("Şifre sıfırlama isteği başarısız: $e");
      return false;
    }
  }

  Future<bool> sendResetCode(String email) async {
    try {
      final res = await _apiServices.post(
        ApiConstants.forgotPassword,
        data: {'email': email},
      );
      print("Reset code response → ${res.statusCode} : ${res.data}");
      return res.statusCode == 200;
    } catch (e) {
      print("sendResetCode error: $e");
      return false;
    }
  }

  Future<String?> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      final res = await _apiServices.post(
        ApiConstants.verifyResetCode,
        data: {'email': email, 'code': code},
      );

      print('KOD DOĞRULAMA RESPONSE: ${res.statusCode}');
      print('DATA: ${res.data}');

      // 🔥 Doğru yerden token'ı çekiyoruz:
      if (res.statusCode == 200 &&
          res.data['data'] != null &&
          res.data['data']['temporaryToken'] != null) {
        return res.data['data']['temporaryToken'];
      }
    } catch (e) {
      print('Kod doğrulama hatası: $e');
    }
    return null;
  }

  Future<bool> resetPassword(String token, String password) async {
    final res = await _apiServices.post(
      ApiConstants.resetPassword,
      data: {'temporaryToken': token, 'password': password},
    );
    return res.statusCode == 200;
  }
}
