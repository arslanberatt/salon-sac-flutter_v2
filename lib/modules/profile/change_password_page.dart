// lib/modules/profile/change_password_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/profile/profile_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class ChangePasswordPage extends GetView<ProfileController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Salon Saç',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(AppSizes.paddingM),
      child: Form(
        key: controller.passwordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => TextFormField(
                obscureText: controller.isNewPasswordHidden.value,
                decoration: InputDecoration(
                  labelText: 'Yeni Şifre',
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isNewPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: controller.isNewPasswordHidden.toggle,
                  ),
                ),
                onChanged: (v) => controller.newPassword.value = v,
                validator: (v) =>
                    (v == null || v.length < 6) ? 'En az 6 karakter' : null,
              ),
            ),

            SizedBox(height: AppSizes.spacingM),

            Obx(
              () => TextFormField(
                obscureText: controller.isConfirmPasswordHidden.value,
                decoration: InputDecoration(
                  labelText: 'Yeni Şifre (Tekrar)',
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: controller.isConfirmPasswordHidden.toggle,
                  ),
                ),
                onChanged: (v) => controller.confirmPassword.value = v,
                validator: (v) =>
                    v != controller.newPassword.value ? 'Eşleşmiyor' : null,
              ),
            ),
            SizedBox(height: AppSizes.spacingM),
            ElevatedButton(
              onPressed: controller.changePassword,
              child: Text('Güncelle'),
            ),
          ],
        ),
      ),
    ),
  );
}
