import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.passwordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Hesabınız için yeni bir şifre belirleyin.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Yeni Şifre',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isLoading ? Icons.lock : Icons.lock_open,
                      ),
                      onPressed: () {}, // Gerekirse şifre görünürlüğü eklenir
                    ),
                  ),
                  obscureText: true,
                  onChanged: (v) => controller.newPassword.value = v,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Şifre gerekli';
                    if (v.length < 6) return 'En az 6 karakter olmalı';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.resetPassword,
                          child: const Text('Şifreyi Güncelle'),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
