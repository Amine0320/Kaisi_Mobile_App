import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/AuthentificationF/controllers/onboarding_controller.dart';
import 'package:kaisi_app/utilities/constants/sizes.dart';
import 'package:kaisi_app/utilities/device/device_utility.dart';

class TOnBoardingSkipButton extends StatelessWidget {
  const TOnBoardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child:
          TextButton(onPressed: controller.skipPage, child: const Text('Skip')),
    );
  }
}
