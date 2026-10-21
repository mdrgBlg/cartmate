import 'package:flutter/widgets.dart';

import '/data/models/auth_exception.dart';

extension AuthErrorMessage on AuthErrorType {
  // `context` is unused until l10n lands; it will resolve the ARB strings.
  String message(BuildContext context) {
    switch (this) {
      case AuthErrorType.invalidEmail:
        return "Please enter a valid email address."; // TODO(l10n): authErrorInvalidEmail
      case AuthErrorType.invalidCredentials:
        return "Incorrect email or password."; // TODO(l10n): authErrorInvalidCredentials
      case AuthErrorType.userNotFound:
        return "No account found for this email."; // TODO(l10n): authErrorUserNotFound
      case AuthErrorType.userDisabled:
        return "This account has been disabled."; // TODO(l10n): authErrorUserDisabled
      case AuthErrorType.emailAlreadyInUse:
        return "An account already exists for this email."; // TODO(l10n): authErrorEmailAlreadyInUse
      case AuthErrorType.weakPassword:
        return "The password is too weak."; // TODO(l10n): authErrorWeakPassword
      case AuthErrorType.tooManyRequests:
        return "Too many attempts. Please try again later."; // TODO(l10n): authErrorTooManyRequests
      case AuthErrorType.networkError:
        return "Network error. Check your connection and try again."; // TODO(l10n): authErrorNetwork
      case AuthErrorType.operationNotAllowed:
        return "This sign-in method is not enabled."; // TODO(l10n): authErrorOperationNotAllowed
      case AuthErrorType.unknown:
        return "Something went wrong. Please try again"; // TODO(l10n): authErrorUnknown
    }
  }
}
