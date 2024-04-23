import 'package:get/get.dart';
import 'package:kaisi_app/auth/auth_user.dart';

abstract class AuthProvider {
  // Get the instance of the AuthProvider.
  static AuthProvider get instance => Get.find();

  // Initialize the authentication provider.
  Future<void> intialize();

  // Get the currently logged-in user.
  AuthUser? get currentUser;

  // Log in with email and password.
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  // Create a new user with email and password.
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  // Log out the current user.
  Future<void> logOut();

  // Send email verification.
  Future<void> sendEmailVerification();

  // Reset password for the provided email.
  Future<void> resetPassword(String email);

  // Delete the user account.
  Future<void> deleteAccount();

  // Re-authenticate user with email and password.
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password);

  // Sign in with Google.
  Future<void> signInWithGoogle();
}
