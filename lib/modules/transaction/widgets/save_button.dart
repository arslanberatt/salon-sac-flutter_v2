import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/transaction_controller.dart';

class SaveButton extends GetView<TransactionController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await controller.createTransaction();
      },
      label: const SizedBox(
        width: double.infinity,
        child: Text('Kaydet', textAlign: TextAlign.center),
      ),
    );
  }
}
