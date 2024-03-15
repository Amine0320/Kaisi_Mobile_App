import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaisi_app/Screens/AuthentificationF/controllers/onboarding_controller.dart';
import 'widgets/onboarding_dot_navigation.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip_button.dart';

/// Onboarding screen to introduce users to the app.
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller for managing onboarding logic and state.
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: "",
                title: "",
                subTitle: "",
              ),
              OnBoardingPage(
                image: "",
                title: "",
                subTitle: "",
              ),
              OnBoardingPage(
                image: "",
                title: "",
                subTitle: "",
              ),
            ],
          ),

          /// Skip Button
          const TOnBoardingSkipButton(),

          /// Dot Navigation SmoothPageIndicator
          const TOnBoardingDotNavigation(),

          /// Circular Button
          const TOnBoardingNextButton(),
        ],
      ),
    );
  }
}
