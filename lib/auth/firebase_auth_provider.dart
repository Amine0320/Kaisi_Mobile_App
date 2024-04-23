import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show
        AuthCredential,
        EmailAuthProvider,
        FirebaseAuth,
        FirebaseAuthException,
        GoogleAuthProvider,
        User,
        UserCredential;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:kaisi_app/Screens/AuthentificationF/Login/login_screen.dart';
// import 'package:kaisi_app/Screens/AuthentificationF/VerifyEmail/components/verify_email_screen.dart';
// import 'package:kaisi_app/Screens/HomeScreen/navigation_home_screen.dart';
// import 'package:kaisi_app/Screens/onboarding/onboarding.dart';
import 'package:kaisi_app/auth/auth_exceptions.dart';
import 'package:kaisi_app/auth/auth_provider.dart';
import 'package:kaisi_app/auth/auth_user.dart';
import 'package:kaisi_app/auth/firebase_auth_exceptions.dart';
import 'package:kaisi_app/auth/firebase_exceptions.dart';
import 'package:kaisi_app/auth/format_exceptions.dart';
import 'package:kaisi_app/auth/platform_exceptions.dart';
import 'package:kaisi_app/firebase_options.dart';
// import 'package:kaisi_app/utilities/local_storage/storage_utility.dart';

/// A class providing Firebase authentication functionality.
class FirebaseAuthProvider implements AuthProvider {
  /// Firebase authentication instance.
  final _auth = FirebaseAuth.instance;

  /// Gets the singleton instance of [FirebaseAuthProvider].
  static FirebaseAuthProvider get instance => Get.find();

  /// Reactive variable for the current Firebase user.
  late final Rx<User?> _firebaseUser;

  /// Local storage instance.
  final deviceStorage = GetStorage();

  /// Getter for the current Firebase user.
  User? get firebaseUser => _firebaseUser.value;

  /// Getter for the user ID.
  String get getUserID => _firebaseUser.value?.uid ?? "";

  /// Getter for the user email.
  String get getUserEmail => _firebaseUser.value?.email ?? "";

  /// Getter for the user display name.
  String get getDisplayName => _firebaseUser.value?.displayName ?? "";

  /// Getter for the user phone number.
  String get getPhoneNo => _firebaseUser.value?.phoneNumber ?? "";

  /// Initializes Firebase.
  @override
  Future<void> intialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /// Creates a new user with the provided email and password.
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotFoundAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  /// Gets the current authenticated user.
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  /// Logs in the user with the provided email and password.
  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotFoundAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  /// Logs out the current user.
  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  /// Sends email verification to the current user.
  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  /// Resets the password for the provided email.
  @override
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  /// Deletes the current user account.
  @override
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Reauthenticates the current user with the provided email and password.
  @override
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Signs in the user with Google authentication.
  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }
}
