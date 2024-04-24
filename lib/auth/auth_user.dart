import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;

  // Constructor
  const AuthUser({required this.isEmailVerified});

  // Factory constructor to create AuthUser from Firebase User.
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);

  get providerData => null;

  // Method to update email verification status after password reset.
  AuthUser updateEmailVerification(bool isEmailVerified) {
    return AuthUser(isEmailVerified: isEmailVerified);
  }

  // Method to reload user data.
  reload() {}

  delete() {}
}
