import 'dart:developer';

class UserInfoModel {
  final String id;
  String firstName;
  String lastName;
  String email;
  String username;
  String phoneNumber;
  String dateOfBirth;
  String gender;

  UserInfoModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
  });

  static Map<String, dynamic> toJson(UserInfoModel userInfoModel) {
    return {
      'id': userInfoModel.id,
      'firstName': userInfoModel.firstName,
      'lastName': userInfoModel.lastName,
      'email': userInfoModel.email,
      'username': userInfoModel.username,
      'phoneNumber': userInfoModel.phoneNumber,
      'dateOfBirth': userInfoModel.dateOfBirth,
      'gender': userInfoModel.gender == "Male" ? true : false,
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
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"] == true ? "Male" : "Female",
      );
    } catch (e) {
      log("EXCEPTION UserModel $e");
    }
    return userModel;
  }
}
