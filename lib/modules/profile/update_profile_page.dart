import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/profile/profile_controller.dart';
import 'package:salon_sac_flutter_v2/modules/profile/widgets/info_input.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class UpdateProfilePage extends GetView<ProfileController> {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profili Düzenle')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Obx(() {
                final user = controller.user.value;
                final file = controller.pickedAvatar.value;
                ImageProvider? image;
                if (file != null) {
                  image = FileImage(File(file.path));
                } else if (user?.avatar != null) {
                  image = NetworkImage(
                    user!.avatar!.startsWith('http')
                        ? user.avatar!
                        : '${ApiConstants.baseUrl}${user.avatar}',
                  );
                }
                return GestureDetector(
                  onTap: controller.pickAvatar,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: image,
                        child: image == null
                            ? const Icon(Icons.person_outline, size: 48)
                            : null,
                        onBackgroundImageError: (_, __) {
                          print("Avatar yüklenemedi");
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: AppSizes.paddingL),
              InfoInput(
                labelText: 'Adı',
                value: controller.name,
                emptyError: 'Adınızı girin',
              ),
              const SizedBox(height: AppSizes.paddingS),

              InfoInput(
                labelText: 'Soyadı',
                value: controller.lastname,
                emptyError: 'Soyadınızı girin',
              ),
              const SizedBox(height: AppSizes.paddingS),

              InfoInput(
                labelText: 'Email',
                value: controller.email,
                emptyError: 'Email girin',
                validator: (v) =>
                    v != null && v.contains('@') ? null : 'Geçerli email girin',
              ),
              const SizedBox(height: AppSizes.paddingS),

              InfoInput(
                labelText: 'Telefon',
                value: controller.phone,
                emptyError: 'Telefon girin',
              ),
              const SizedBox(height: AppSizes.paddingL),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.saveProfile,
                  child: const Text('Kaydet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
