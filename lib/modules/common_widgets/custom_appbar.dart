import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_sac_flutter_v2/modules/admin/admin_controller.dart';
import 'package:salon_sac_flutter_v2/utils/constants/app_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
        child: Text(
          'Salon Saç',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      centerTitle: false,
      actionsPadding: EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
      actions: [
        IconButton(
          onPressed: () => Get.find<AdminController>().goToTransaction(),
          icon: const Icon(Icons.add_task_rounded),
        ),
        IconButton(
          onPressed: () => Get.find<AdminController>().goToAdvance(),
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}
