import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kaisi_app/Screens/AuthentificationF/controllers/onboarding_controller.dart';
import 'package:kaisi_app/Screens/helpers/helper_functions.dart';
import 'package:kaisi_app/utilities/constants/colors.dart';
import 'package:kaisi_app/utilities/constants/sizes.dart';
import 'package:kaisi_app/utilities/device/device_utility.dart';

class TOnBoardingNextButton extends StatelessWidget {
  const TOnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? TColors.primary : Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
