import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kaisi_app/auth/auth_provider.dart';
import 'package:kaisi_app/auth/auth_user.dart';
import 'package:kaisi_app/auth/firebase_auth_provider.dart';
import 'package:kaisi_app/firebase_options.dart';

class AuthService implements AuthProvider {
  // Get the instance of the AuthService.
  static AuthService get instance => Get.find();

  final AuthProvider provider;

  // Constructor
  const AuthService(this.provider);

  // Factory constructor for creating AuthService with FirebaseAuthProvider.
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> intialize() async {
    // Initialize Firebase app with default options.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> resetPassword(String email) => provider.resetPassword(email);

  @override
  Future<void> deleteAccount() => provider.deleteAccount();

  @override
  Future<void> reAuthenticateWithEmailAndPassword(
          String email, String password) =>
      provider.reAuthenticateWithEmailAndPassword(email, password);

  @override
  Future<void> signInWithGoogle() => provider.signInWithGoogle();
}
