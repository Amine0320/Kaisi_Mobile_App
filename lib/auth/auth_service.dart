import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kaisi_app/auth/auth_provider.dart';
import 'package:kaisi_app/auth/auth_user.dart';
import 'package:kaisi_app/auth/firebase_auth_provider.dart';
import 'package:kaisi_app/firebase_options.dart';

class AuthService implements AuthProvider {
  static AuthService get instance => Get.find();
  // late final Rx<User?> _firebaseUser;
  // /// Getters
  // User? get firebaseUser => _firebaseUser.value;

  // String get getUserID => _firebaseUser.value?.uid ?? "";

  // String get getUserEmail => _firebaseUser.value?.email ?? "";

  // String get getDisplayName => _firebaseUser.value?.displayName ?? "";

  // String get getPhoneNo => _firebaseUser.value?.phoneNumber ?? "";
  final AuthProvider provider;

  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> intialize() async {
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
  Future<void> signInWithFacebook() => provider.signInWithFacebook();
  @override
  Future<void> signInWithGoogle() => provider.signInWithGoogle();
}
