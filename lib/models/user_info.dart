import 'dart:developer';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNumber;
  final String password;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.password,
  });

  static UserModel? fromJson(Map<String, dynamic> json) {
    UserModel? userModel;
    try {
      userModel = UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
      );
    } catch (e) {
      log("EXCEPTION UserModel $e");
    }
    return userModel;
  }
}
