import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaisi_app/Models/user_model.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Login/login_screen.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Login/re_authenticate_user_login_form.dart';
import 'package:kaisi_app/Screens/helpers/network_manager.dart';
import 'package:kaisi_app/Screens/loaders/circular_loader.dart';
import 'package:kaisi_app/Screens/popups/full_screen_loader.dart';
import 'package:kaisi_app/Screens/popups/loaders.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/auth/firebase_auth_provider.dart';
import 'package:kaisi_app/data/user/user_represitory.dart';
import 'package:kaisi_app/utilities/constants/sizes.dart';

/// Controller to manage user-related functionality.
class UserController extends GetxController {
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final imageUploading = false.obs;
  final profileLoading = false.obs;
  final profileImageUrl = ''.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user as UserModel?);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(
      {UserModel? user, UserCredential? userCredentials}) async {
    try {
      // First UPDATE Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // If no record already stored.
      if (this.user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final customUsername = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          // Map data
          final newUser = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
            username: customUsername,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );
          // Save user data
          // await userRepository.saveUserRecord(newUser);

          // Assign new user to the RxUser so that we can use it through out the app.
          this.user(newUser);
        } else if (user != null) {
          // Save Model when user registers using Email and Password
          // await userRepository.saveUserRecord(user);
          // Assign new user to the RxUser so that we can use it through out the app.
          this.user(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'La sauvegarde de vos données a échoué.',
        message:
            "Une erreur s'est produite lors de la sauvegarde de vos informations. Veuillez réessayer d'enregistrer vos données dans votre profil.",
      );
    }
  }

  /// Upload Profile Picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final uploadedImage =
            await userRepository.uploadImage('Users/Images/Profile/', image);
        profileImageUrl.value = uploadedImage;
        Map<String, dynamic> newImage = {'Photo de profil': uploadedImage};
        await userRepository.updateSingleField(newImage);
        user.value.profilePicture = uploadedImage;
        user.refresh();

        imageUploading.value = false;
        TLoaders.successSnackBar(
            title: 'Felicitations !',
            message: 'la photo de profil est mis a jour ');
      }
    } catch (e) {
      imageUploading.value = false;
      TLoaders.errorSnackBar(title: 'Oh', message: 'un erreur se produit: $e');
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Supprimer le compte',
      middleText:
          "êtes-vous certain(e) de vouloir supprimer votre compte définitivement ? Cette action est irréversible et toutes vos données seront définitivement supprimées.",
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Supprimer')),
      ),
      cancel: OutlinedButton(
        child: const Text('Annuler'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'En traitement', "assets/animation/141594-animation-of-docer.json");

      /// First re-authenticate user
      final auth = FirebaseAuthProvider.instance;
      final provider =
          auth.firebaseUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'facebook.com') {
          await auth.signInWithFacebook();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'En traitement', "assets/animation/141594-animation-of-docer.json");

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthService.firebase().reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthService.firebase().deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Logout Loader Function
  logout() {
    try {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Deconnecter',
        middleText: 'Vous etes sure de deconncter',
        confirm: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Confirmer'),
          ),
          onPressed: () async {
            onClose();

            /// On Confirmation show any loader until user Logged Out.
            Get.defaultDialog(
              title: '',
              barrierDismissible: false,
              backgroundColor: Colors.transparent,
              content: const TCircularLoader(),
            );
            await AuthService.firebase().logOut();
          },
        ),
        cancel: OutlinedButton(
          child: const Text('Annuler'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        ),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh', message: e.toString());
    }
  }
}
