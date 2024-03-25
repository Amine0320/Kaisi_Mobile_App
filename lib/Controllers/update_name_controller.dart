import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaisi_app/Screens/SideBar/profile/profile_screen.dart';
import 'package:kaisi_app/Screens/helpers/network_manager.dart';
import 'package:kaisi_app/Screens/popups/full_screen_loader.dart';
import 'package:kaisi_app/Screens/popups/loaders.dart';
import 'package:kaisi_app/data/user/user_represitory.dart';
import 'user_controller.dart';

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Nous mettons à jour vos informations...',
          "assets/animation/141594-animation-of-docer.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'prenom': firstName.text.trim(),
        'Nom': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Félicitations !', message: 'Votre nom a été mis à jour.');

      // Move to previous screen.
      Get.off(() => const ProfileScreen(
            phoneNumber: '',
            email: '',
            firstname: '',
            lastname: '',
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Zut alors !', message: e.toString());
    }
  }
}
