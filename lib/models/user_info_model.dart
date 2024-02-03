import 'dart:developer';

class UserInfoModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;

  UserInfoModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
  });

  static Map<String, dynamic> toJson(UserInfoModel userInfoModel) {
    return {
      'id': userInfoModel.id,
      'firstName': userInfoModel.firstName,
      'lastName': userInfoModel.lastName,
      'email': userInfoModel.email,
      'username': userInfoModel.username,
      'phoneNumber': userInfoModel.phoneNumber,
    };
  }

  static UserInfoModel? fromJson(Map<String, dynamic> json) {
    UserInfoModel? userModel;
    try {
      userModel = UserInfoModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
      );
    } catch (e) {
      log("EXCEPTION UserModel $e");
    }
    return userModel;
  }
}
