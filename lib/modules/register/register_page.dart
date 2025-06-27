import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/register/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ad'),
                onChanged: (v) => controller.name.value = v,
                validator: (v) => v == null || v.isEmpty ? 'Ad gerekli' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Soyad'),
                onChanged: (v) => controller.lastname.value = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Soyad gerekli' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Telefon'),
                keyboardType: TextInputType.phone,
                onChanged: (v) => controller.phone.value = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Telefon gerekli' : null,
              ),
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
                    v == null || v.length < 6 ? 'En az 6 karakter' : null,
              ),
              const SizedBox(height: 24),
              Obx(
                () => controller.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: controller.registerUser,
                        child: const Text('Kayıt Ol'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
