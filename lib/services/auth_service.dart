import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';
import 'package:salon_sac_flutter_v2/services/storage_service.dart';

class AuthService extends GetxService {
  late final StorageService _storageService;
  late final ApiServices _apiServices;

  final Rx<AppUser?> currentUser = Rx<AppUser?>(null);

  Future<AuthService> init() async {
    _storageService = Get.find<StorageService>();
    _apiServices = Get.find<ApiServices>();
    await isAuthenticated();
    return this;
  }

  Future<AppUser?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiServices.post(
        ApiConstants.login,
        data: {"email": email, "password": password},
      );

      final token = response.data["token"];
      if (token == null) return null;

      await _storageService.setValue(StorageKeys.userToken, token);
      final profileRes = await getProfile();
      currentUser.value = profileRes;

      return profileRes;
    } catch (e) {
      currentUser.value = null;
      return null;
    }
  }

  Future<AppUser?> register({
    required String name,
    required String lastname,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _apiServices.register(
        name: name,
        lastname: lastname,
        email: email,
        phone: phone,
        password: password,
      );
      return AppUser.fromJson(response.data["data"]);
    } catch (e) {
      currentUser.value = null;
      return null;
    }
  }

  Future<AppUser?> getProfile() async {
    try {
      final response = await _apiServices.get(ApiConstants.profile);
      if (response.statusCode == 200) {
        final user = AppUser.fromJson(response.data["data"]);
        currentUser.value = user;
        return user;
      }
      return null;
    } catch (e) {
      print('Kullanıcı bilgileri getirilirken hata: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _storageService.remove(StorageKeys.userToken);
      currentUser.value = null;
    } catch (e) {
      print('Çıkış yapılırken hata');
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      final token = _storageService.getValue<String>(StorageKeys.userToken);
      print('token: $token');
      if (token == null) {
        currentUser.value = null;
        return false;
      }
      final user = await getProfile();
      if (user != null) {
        currentUser.value = user;
        return true;
      } else {
        await _storageService.remove(StorageKeys.userToken);
        currentUser.value = null;
        return false;
      }
    } catch (e) {
      await _storageService.remove(StorageKeys.userToken);
      currentUser.value = null;
      return false;
    }
  }
}
