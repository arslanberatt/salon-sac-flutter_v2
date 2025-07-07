import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/register/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Hesap Oluştur",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Devam etmek için bilgilerini doldur.",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              _buildInput(
                label: 'Ad',
                onChanged: (v) => controller.name.value = v,
                validator: (v) => v == null || v.isEmpty ? 'Ad gerekli' : null,
              ),
              const SizedBox(height: 16),
              _buildInput(
                label: 'Soyad',
                onChanged: (v) => controller.lastname.value = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Soyad gerekli' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Telefon',
                  border: OutlineInputBorder(),
                  hintText: '5XXXXXXXXX',
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) => controller.phone.value = v,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Telefon gerekli';
                  if (v.length != 10) return '10 haneli olmalı';
                  if (!v.startsWith('5')) {
                    return 'Geçerli bir cep numarası girin';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                    return 'Sadece rakam girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInput(
                label: 'E-posta',
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => controller.email.value = v,
                validator: (v) =>
                    v == null || v.isEmpty ? 'E-posta gerekli' : null,
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !controller.isPasswordVisible.value,
                  onChanged: (v) => controller.password.value = v,
                  validator: (v) => v == null || v.length < 6
                      ? 'En az 6 karakter olmalı'
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Şifreyi Tekrar Gir',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !controller.isPasswordVisible.value,
                  onChanged: (v) => controller.confirmPassword.value = v,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Tekrar girin';
                    if (v != controller.password.value) {
                      return 'Şifreler eşleşmiyor';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32),
              Obx(
                () => controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.registerUser,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Kayıt Ol"),
                        ),
                      ),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: controller.goToLogin,
                  child: Text.rich(
                    TextSpan(
                      text: "Zaten hesabın var mı?  ",
                      style: const TextStyle(
                        color: Colors.grey,
                      ), // Ana metin rengi
                      children: [
                        TextSpan(
                          text: "Giriş Yap",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    TextInputType? keyboardType,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
