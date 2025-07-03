import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/setting/widgets/setting_item.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_colors.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';
import 'support_controller.dart';

class SupportPage extends GetView<SupportController> {
  const SupportPage({super.key});

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
        padding: EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSizes.spacingXL),
            Icon(
              Icons.headset_mic_outlined,
              size: 96,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.inputBorder
                  : AppColors.backgroundDark,
            ),
            SizedBox(height: AppSizes.spacingXL),
            Text(
              'Geliştiriciyle iletişime geçin',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSizes.spacingS),
            Text(
              'Soru, öneri veya geri bildirim için iletişime geçebilirsiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: AppSizes.spacingXL),
            SettingsItem(
              icon: Icons.chat_outlined,
              title: 'WhatsApp üzerinden iletişim',
              onTap: controller.openWhatsApp,
            ),
            SizedBox(height: AppSizes.spacingS),
            SettingsItem(
              icon: Icons.email_outlined,
              title: 'E-posta ile iletişim',
              onTap: controller.sendEmail,
            ),
            SizedBox(height: AppSizes.spacingXL),
            Text(
              'Mesajınıza en kısa sürede dönüş sağlanacaktır.',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
