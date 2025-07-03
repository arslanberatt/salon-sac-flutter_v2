import 'package:salon_sac_flutter_v2/core/base_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportController extends BaseController {
  final phone = '5442518830';
  final email = 'arslanberattdev@gmail.com';

  Future<void> openWhatsApp() async {
    final uri = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> sendEmail() async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
