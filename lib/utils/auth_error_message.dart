import 'package:flutter/widgets.dart';

import '/core/l10n/app_localizations.dart';
import '/data/models/auth_exception.dart';

extension AuthErrorMessage on AuthErrorType {
  String message(BuildContext context) {
    final localization = AppLocalizations.of(context);
    switch (this) {
      case AuthErrorType.invalidEmail:
        return localization.authErrorInvalidEmail;
      case AuthErrorType.invalidCredentials:
        return localization.authErrorInvalidCredentials;
      case AuthErrorType.userNotFound:
        return localization.authErrorUserNotFound;
      case AuthErrorType.userDisabled:
        return localization.authErrorUserDisabled;
      case AuthErrorType.emailAlreadyInUse:
        return localization.authErrorEmailAlreadyInUse;
      case AuthErrorType.weakPassword:
        return localization.authErrorWeakPassword;
      case AuthErrorType.tooManyRequests:
        return localization.authErrorTooManyRequests;
      case AuthErrorType.networkError:
        return localization.authErrorNetwork;
      case AuthErrorType.operationNotAllowed:
        return localization.authErrorOperationNotAllowed;
      case AuthErrorType.unknown:
        return localization.authErrorUnknown;
    }
  }
}
