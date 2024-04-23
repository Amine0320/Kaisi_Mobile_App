import 'package:flutter/foundation.dart' show immutable;
import 'package:kaisi_app/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

// Abstract class representing authentication states.
@immutable
abstract class AuthState {
  const AuthState();
}

// State indicating that authentication is initialized.
class AuthStateOnIntialized extends AuthState {
  const AuthStateOnIntialized();
}

// State indicating that user registration is in progress.
class AuthStateRegistering extends AuthState {
  final Exception? execption;
  const AuthStateRegistering(this.execption);
}

// State indicating that user is logged in.
class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

// State indicating that user needs email verification.
class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

// State indicating that user is logged out.
class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({required this.exception, required this.isLoading});

  @override
  List<Object?> get props => [exception, isLoading];
}
