import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/profile/profile_controller.dart';
import 'package:salon_sac_flutter_v2/modules/profile/widgets/info_card.dart';
import 'package:salon_sac_flutter_v2/services/api_service.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: controller.goToUpdate,
          ),
        ],
      ),
      body: Obx(() {
        final user = controller.user.value;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          children: [
            Center(
              child: CircleAvatar(
                radius: 64,
                backgroundColor: Colors.grey.shade300,
                child: user.avatar != null
                    ? ClipOval(
                        child: Image.network(
                          '${ApiConstants.baseUrl}${user.avatar}',
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.person, size: 48),
              ),
            ),
            const SizedBox(height: AppSizes.paddingM),
            const PersonalInfoCard(),
          ],
        );
      }),
    );
  }
}
