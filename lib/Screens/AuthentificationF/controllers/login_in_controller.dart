import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaisi_app/Controllers/user_controller.dart';
import 'package:kaisi_app/Screens/helpers/network_manager.dart';
import 'package:kaisi_app/Screens/popups/full_screen_loader.dart';
import 'package:kaisi_app/Screens/popups/loaders.dart';
// import 'package:kaisi_app/auth/auth_service.dart';
// import 'package:kaisi_app/auth/firebase_auth_provider.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// -- Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', "");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using EMail & Password Authentication
      // final userCredentials =
      //     await AuthService.firebase().logIn(email: '', password: '');

      // Assign user data to RxUser of UserController to use in app
      await userController.fetchUserRecord();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      // await FirebaseAuthProvider.instance.screenRedirect(userCredentials.user);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', "");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // // Google Authentication
      // final userCredentials = await AuthService.instance.signInWithGoogle();

      // // Save Authenticated user data in the Firebase Firestore
      // await userController.saveUserRecord(userCredentials: userCredentials);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      // await FirebaseAuthProvider.instance.screenRedirect(userCredentials?.user);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Facebook SignIn Authentication
  Future<void> facebookSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', "");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Facebook Authentication
      // final userCredentials = await AuthService.instance.signInWithFacebook();

      // // Save Authenticated user data in the Firebase Firestore
      // await userController.saveUserRecord(userCredentials: userCredentials);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      // await FirebaseAuthProvider.instance.screenRedirect(userCredentials.user);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
