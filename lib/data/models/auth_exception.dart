enum AuthErrorType {
  invalidEmail,
  invalidCredentials,
  userNotFound,
  userDisabled,
  emailAlreadyInUse,
  weakPassword,
  tooManyRequests,
  networkError,
  operationNotAllowed,
  unknown,
}

class AuthException implements Exception {
  const AuthException(this.type, {this.cause});

  final AuthErrorType type;

  /// Original error (e.g. FirebaseAuthException), kept for logging only.
  final Object? cause;

  @override
  String toString() => 'AuthException($type, cause: $cause)';
}
