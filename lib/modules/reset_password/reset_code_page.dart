import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'reset_password_controller.dart';

class ResetCodePage extends GetView<ResetPasswordController> {
  const ResetCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kod Doğrulama")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.codeFormKey,
          child: Column(
            children: [
              Text(
                "E-postana gelen 6 haneli kodu gir:",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Kod",
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => controller.code.value = v,
                validator: (v) =>
                    v == null || v.length != 6 ? "6 haneli kod gir" : null,
              ),
              const SizedBox(height: 24),
              Obx(
                () => controller.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: controller.verifyResetCode,
                        child: const Text("Kodu Doğrula"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
