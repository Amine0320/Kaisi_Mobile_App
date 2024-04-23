// Exception thrown when user is not found during login.
class UserNotFoundAuthException implements Exception {}

// Exception thrown when wrong password is provided during login.
class WrongPasswordAuthException implements Exception {}

// Exception thrown when the provided password is weak during registration.
class WeakPasswordAuthException implements Exception {}

// Exception thrown when the provided email is already in use during registration.
class EmailAlreadyInUseAuthException implements Exception {}

// Exception thrown when the provided email is invalid during registration.
class InvalidEmailAuthException implements Exception {}

// Generic authentication exception.
class GenericAuthException implements Exception {}

// Exception thrown when the user is not logged in.
class UserNotLoggedInAuthException implements Exception {}
