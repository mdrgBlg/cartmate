class GlobalUrl {
  static Uri getUrl(String variable) {
    return Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$variable?key=AIzaSyC4xgdKoYXGsW6stCj10kyb25IPRPm9j7E');
  }
}
