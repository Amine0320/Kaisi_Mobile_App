import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaisi_app/Screens/AuthentificationF/controllers/signup_controller.dart';
import 'package:kaisi_app/Screens/SideBar/profile/profile_screen.dart';
import 'package:kaisi_app/Screens/helpers/network_manager.dart';
import 'package:kaisi_app/Screens/popups/full_screen_loader.dart';
import 'package:kaisi_app/Screens/popups/loaders.dart';
import 'package:kaisi_app/data/user/user_represitory.dart';
import 'user_controller.dart';

/// Controller to manage user-related functionality.
/// Controller responsible for managing the update of user names.
class UpdateNameController extends GetxController {
  /// Gets the singleton instance of [UpdateNameController].
  static UpdateNameController get instance => Get.find();

  /// Controller for the first name text field.
  final firstName = TextEditingController();

  /// Controller for the last name text field.
  final lastName = TextEditingController();

  /// Instance of [UserController].
  final userController = UserController.instance;

  /// Instance of [SignupController].
  final userform = SignupController.instance;

  /// Instance of [UserRepository].
  final userRepository = Get.put(UserRepository());

  /// Form key for the update user name form.
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Initializes the user's name when the controller is initialized.
  Future<void> initializeNames() async {
    // firstName.text = userform.firstName;
    // lastName.text = userform.lastName;
    // lastName.text = userController.user.value.lastName;
  }

  /// Updates the user's name.
  Future<void> updateUserName() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Nous mettons à jour vos informations...',
        "assets/animation/141594-animation-of-docer.json",
      );

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
      // userform.firstName = firstName.text.trim();
      // userform.lastName = lastName.text.trim();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
        title: 'Félicitations !',
        message: 'Votre nom a été mis à jour.',
      );

      // Move to previous screen.
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Zut alors !', message: e.toString());
    }
  }
}
