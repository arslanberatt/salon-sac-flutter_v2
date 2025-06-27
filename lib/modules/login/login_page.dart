import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-posta'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => controller.email.value = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'E-posta gerekli' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                onChanged: (v) => controller.password.value = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Şifre gerekli' : null,
              ),
              const SizedBox(height: 24),
              Obx(
                () => controller.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: controller.loginWithEmail,
                        child: const Text('Giriş Yap'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
