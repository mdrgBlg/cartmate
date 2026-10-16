import '/data/models/auth_exception.dart';

AuthErrorType fromException(Exception exception) {
  if (exception is AuthException) {
    return exception.type;
  }
  return AuthErrorType.unknown;
}

double calculateDiscountPrice(int price, int discount) {
  return price - price * (discount / 100);
}
