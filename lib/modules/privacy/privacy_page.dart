import 'package:flutter/material.dart';

class PrivacyTermsPage extends StatelessWidget {
  const PrivacyTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Gizlilik Politikası',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Bu uygulama, kullanıcıların kişisel verilerini saygı ve gizlilik ilkeleri çerçevesinde korur. Aşağıda hangi verileri nasıl topladığımızı ve kullandığımızı açıklıyoruz.',
            ),
            SizedBox(height: 8),
            Text(
              'Toplanan Veriler:\n'
              '- İletişim bilgileri (e-posta adresi, telefon numarası)\n'
              '- Cihaz bilgileri ve kullanım verileri\n'
              '- Uygulama içi etkileşim kayıtları',
            ),
            SizedBox(height: 8),
            Text(
              'Verilerin Kullanım Amacı:\n'
              '- Hizmet kalitesini iyileştirmek\n'
              '- Destek ve geri bildirim süreçlerini yönetmek\n',
            ),
            SizedBox(height: 24),
            Text(
              'Kullanım Koşulları',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Sorumluluk Reddi:\n'
              'Uygulama, "olduğu gibi" sunulmaktadır. Geliştirici hiçbir koşulda dolaylı, özel veya cezai tazminatlardan sorumlu tutulamaz.',
            ),
            SizedBox(height: 8),
            Text(
              'Değişiklikler:\n'
              'Bu gizlilik politikası ve kullanım koşulları zaman zaman güncellenebilir. Güncellemeler geliştirici tarafından duyurulacaktır.',
            ),
          ],
        ),
      ),
    );
  }
}
