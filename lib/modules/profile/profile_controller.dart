import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:salon_sac_flutter_v2/models/app_user.dart';
import 'package:salon_sac_flutter_v2/modules/setting/setting_controller.dart';
import 'package:salon_sac_flutter_v2/repositories/user_repository.dart';
import 'package:salon_sac_flutter_v2/routers/app_pages.dart';
import 'package:salon_sac_flutter_v2/services/auth_service.dart';

class ProfileController extends BaseController {
  final AuthService _auth = Get.find<AuthService>();
  final UserRepository _userRepository = Get.find<UserRepository>();
  final ImagePicker _picker = ImagePicker();

  final name = ''.obs;
  final lastname = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final newPassword = ''.obs;
  final confirmPassword = ''.obs;
  final isNewPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final passwordFormKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final pickedAvatar = Rxn<XFile>();

  Rx<AppUser?> get user => _auth.currentUser;

  void goToProfile() {
    Get.toNamed(AppRoutes.PROFILE);
  }

  void goToChangePassword() {
    Get.toNamed(AppRoutes.CHANGEPASSWORD);
  }

  void goToUpdate() {
    Get.toNamed(AppRoutes.UPDATEPROFILE);
  }

  @override
  void onInit() {
    super.onInit();
    final u = user.value;
    name.value = u?.name ?? '';
    lastname.value = u?.lastname ?? '';
    email.value = u?.email ?? '';
    phone.value = u?.phone ?? '';
  }

  Future<void> pickAvatar() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedAvatar.value = file; // 👈 DEĞİŞTİ
    }
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    final body = {
      'name': name.value,
      'lastname': lastname.value,
      'email': email.value,
      'phone': phone.value,
    };

    try {
      setLoading(true);
      final updated = await _userRepository.updateProfile(
        body: body,
        avatarFile: pickedAvatar.value,
      );
      if (updated != null) {
        _auth.currentUser.value = updated;
        pickedAvatar.value = null;
        Get.find<SettingController>().refreshUser();
        Get.back();
        showSuccessSnackbar(message: 'Profil başarıyla güncellendi');
      } else {
        showErrorSnackbar(message: 'Profil güncellenirken hata oluştu!');
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> changePassword() async {
    if (!passwordFormKey.currentState!.validate()) return;
    if (newPassword.value != confirmPassword.value) {
      showErrorSnackbar(message: 'Şifreler eşleşmiyor');
      return;
    }
    try {
      setLoading(true);
      final updated = await _userRepository.changePassword(newPassword.value);
      if (updated != null) {
        _auth.currentUser.value = updated;

        Get.back();
        await Future.delayed(Duration(seconds: 2));
        showSuccessSnackbar(message: 'Şifre başarıyla değiştirildi');
      } else {
        showErrorSnackbar(message: 'Hata oluştu');
      }
    } finally {
      setLoading(false);
    }
  }
}
