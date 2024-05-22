// // TEST DRIVEN DEPLOYMENT TDD
// import 'package:flutter_test/flutter_test.dart';
// import 'package:kaisi_app/auth/auth_exceptions.dart';
// import 'package:kaisi_app/auth/auth_provider.dart';
// import 'package:kaisi_app/auth/auth_user.dart';

// void main() {
//   group('Mock Authentification', () {
//     final provider = MockAuthProvider();
//     test('Should Not be initalized to begin with', () {
//       expect(provider.isInitialized, false);
//     });
//     test('Cannot log out if not intialized', () {
//       expect(
//         provider.logOut(),
//         throwsA(const TypeMatcher<NotIntalizedException>()),
//       );
//     });
//     test('Should be able to be initialized', () async {
//       await provider.intialize();
//       expect(provider.isInitialized, true);
//     });
//     test('User should be null', () {
//       expect(provider.currentUser, null);
//     });
//     test(
//       'Should be able to initialize in less than 2 seconds',
//       () async {
//         await provider.intialize();
//         expect(provider.isInitialized, true);
//       },
//       timeout: const Timeout(Duration(seconds: 2)),
//     );
//     test('Create user should delegate to Login function', () async {
//       final badEmailUser = provider.createUser(
//           email: 'afif12tn@gmail.com', password: 'anypassword');
//       expect(
//         badEmailUser,
//         throwsA(const TypeMatcher<UserNotFoundAuthException>()),
//       );

//       final badPasswordUser = provider.createUser(
//           email: 'someone@splinter.com', password: 'foobar');
//       expect(
//         badPasswordUser,
//         throwsA(const TypeMatcher<WrongPasswordAuthException>()),
//       );

//       final user = await provider.createUser(email: 'foo', password: 'bar');
//       expect(provider.currentUser, user);
//       expect(user.isEmailVerified, false);
//     });
//     test('logged in user should be able to get verified', () {
//       provider.sendEmailVerification();
//       final user = provider.currentUser;
//       expect(user, isNotNull);
//       expect(user!.isEmailVerified, true);
//     });
//     test('Should be able to log out and log in again ', () async {
//       await provider.logOut();
//       await provider.logIn(email: 'email', password: 'password');
//       final user = provider.currentUser;
//       expect(user, isNotNull);
//     });
//     // The forget password test
//     test('Should be able to reset password', () async {
//       const email = "afif12tn@gmail.com";
//       provider._email = email; // Provide a valid email address
//       try {
//         await provider.resetPassword(email);
//         expect(true, true);
//       } catch (e) {
//         fail('Unexpected exception: $e');
//       }
//     });
//   });
// }

// class NotIntalizedException implements Exception {}

// class EmailNotFoundException implements Exception {}

// class MockAuthProvider implements AuthProvider {
//   // Declaration
//   String? _email;
//   AuthUser? _user;
//   var _isInitialized = false;
//   bool get isInitialized => _isInitialized;
//   // Mock Create User
//   @override
//   Future<AuthUser> createUser(
//       {required String email, required String password}) async {
//     if (!isInitialized) throw NotIntalizedException();
//     await Future.delayed(const Duration(seconds: 1));
//     return logIn(email: email, password: password);
//   }

//   // Mock Current User
//   @override
//   AuthUser? get currentUser => _user;

//   @override
//   Future<void> intialize() async {
//     await Future.delayed(const Duration(seconds: 1));
//     _isInitialized = true;
//   }

//   @override
//   Future<AuthUser> logIn({required String email, required String password}) {
//     if (!isInitialized) throw NotIntalizedException();
//     if (email == 'afif12tn@gmail.com') throw UserNotFoundAuthException();
//     if (password == 'foobar') throw WrongPasswordAuthException();
//     const user = AuthUser(isEmailVerified: false);
//     _user = user;
//     return Future.value(user);
//   }

//   @override
//   Future<void> logOut() async {
//     if (!isInitialized) throw NotIntalizedException();
//     if (_user == null) throw UserNotFoundAuthException();
//     await Future.delayed(const Duration(seconds: 1));
//     _user = null;
//   }

//   @override
//   Future<void> sendEmailVerification() async {
//     if (!isInitialized) throw NotIntalizedException();
//     final user = _user;
//     if (user == null) throw UserNotFoundAuthException();
//     const newUser = AuthUser(isEmailVerified: true);
//     _user = newUser;
//   }

// // Test Forget password
//   @override
//   Future<void> resetPassword(String email) async {
//     if (!isInitialized) throw NotIntalizedException();
//     if (_email == null || _email != email) throw EmailNotFoundException();
//     // Your password reset logic here
//     await Future.delayed(
//         const Duration(seconds: 2)); // Simulating async operation
//     return;
//   }

//   @override
//   Future<void> deleteAccount() {
//     // TODO: implement deleteAccount
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> reAuthenticateWithEmailAndPassword(
//       String email, String password) {
//     // TODO: implement reAuthenticateWithEmailAndPassword
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> signInWithGoogle() {
//     // TODO: implement signInWithGoogle
//     throw UnimplementedError();
//   }
// }
