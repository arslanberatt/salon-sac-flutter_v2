import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoInput extends StatelessWidget {
  final String labelText;
  final RxString value;
  final String emptyError;
  final String? Function(String?)? validator;

  const InfoInput({
    Key? key,
    required this.labelText,
    required this.value,
    this.emptyError = 'Bu alan boş geçilemez',
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        initialValue: value.value,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        onChanged: (v) => value.value = v,
        validator: (v) {
          if (v == null || v.trim().isEmpty) {
            return emptyError;
          }
          if (validator != null) {
            return validator!(v);
          }
          return null;
        },
      );
    });
  }
}
