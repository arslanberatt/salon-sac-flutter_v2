// forgot_password_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'reset_password_controller.dart';

class ForgotPasswordPage extends GetView<ResetPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Şifremi Unuttum')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.emailFormKey,
          child: Column(
            children: [
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-posta'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => controller.email.value = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'E-posta gerekli' : null,
              ),
              const SizedBox(height: 24),
              Obx(
                () => controller.isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: controller.sendResetCode,
                        child: const Text('Kod Gönder'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
