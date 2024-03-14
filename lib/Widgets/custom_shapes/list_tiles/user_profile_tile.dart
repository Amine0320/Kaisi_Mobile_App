import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kaisi_app/controllers/user_controller.dart';
import 'package:kaisi_app/utilities/constants/colors.dart';
import '../images/t_circular_image.dart';

class TUserProfileTile extends StatelessWidget {
  TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final controller = UserController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isNetworkImage = controller.user.value.profilePicture.isNotEmpty;
      final image = isNetworkImage
          ? controller.user.value.profilePicture
          : "assets/images/user.png";
      return ListTile(
        leading: TCircularImage(
            padding: 0,
            image: image,
            width: 50,
            height: 50,
            isNetworkImage: isNetworkImage),
        title: Text(controller.user.value.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.white)),
        subtitle: Text(controller.user.value.email,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: TColors.white)),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Iconsax.edit, color: TColors.white)),
      );
    });
  }
}
