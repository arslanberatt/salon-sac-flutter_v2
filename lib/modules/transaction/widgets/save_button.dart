import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/controllers/transaction_controller.dart';

class SaveButton extends GetView<TransactionController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await controller.createTransaction();
      },
      child: const SizedBox(
        width: double.infinity,
        child: Text('Kaydet', textAlign: TextAlign.center),
      ),
    );
  }
}
