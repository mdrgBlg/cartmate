import '../../data/models/auth_exception.dart';

extension ExceptionExtension on Exception {
  AuthErrorType getAuthErrorType() {
    if (this is AuthException) {
      return (this as AuthException).type;
    }
    return AuthErrorType.unknown;
  }
}
