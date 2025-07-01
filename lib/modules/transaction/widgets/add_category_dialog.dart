import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/transaction/controllers/category_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<CategoryController>(CategoryController());
    return AlertDialog(
      title: Text(
        'Kategori Ekle',
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Kategori Adı',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.categoryName.value = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kategori adı boş olamaz';
                }
                return null;
              },
            ),
            SizedBox(height: AppSizes.spacingS),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Get.back(), child: Text('iptal')),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    if (!controller.isLoading) {
                      await controller.createCategory();
                    }
                  },
                  child: Text('Kaydet'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
