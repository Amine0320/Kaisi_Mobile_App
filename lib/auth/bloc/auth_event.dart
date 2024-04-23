import 'package:flutter/foundation.dart' show immutable;

// Abstract class representing authentication events.
@immutable
abstract class AuthEvent {
  const AuthEvent();
}

// Event for initializing authentication.
class AuthEventIntialize extends AuthEvent {
  const AuthEventIntialize();
}

// Event for user login.
class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn(this.email, this.password);
}

// Event for user logout.
class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

// Event for sending email verification.
class AuthEvenSendEmailVerification extends AuthEvent {
  const AuthEvenSendEmailVerification();
}

// Event for user registration.
class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister(this.email, this.password);
}

// Event indicating the need for user registration.
class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}
