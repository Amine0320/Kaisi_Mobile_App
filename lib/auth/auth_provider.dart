import 'package:get/get.dart';
import 'package:kaisi_app/auth/auth_user.dart';

abstract class AuthProvider {
  static AuthProvider get instance => Get.find();
  Future<void> intialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> resetPassword(String email);
  Future<void> deleteAccount();
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password);
}
