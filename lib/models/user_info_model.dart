class UserInfoModel {
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

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    id: json["id"] as String,
    firstName: json["firstName"] as String,
    lastName: json["lastName"] as String,
    email: json["email"] as String,
    username: json["username"] as String,
    phoneNumber: json["phoneNumber"] as String,
    dateOfBirth: json["dateOfBirth"] as String,
    gender: json["gender"] == true ? "Male" : "Female",
  );

  final String id;
  String firstName;
  String lastName;
  String email;
  String username;
  String phoneNumber;
  String dateOfBirth;
  String gender;

  static Map<String, dynamic> toJson(UserInfoModel userInfoModel) {
    return {
      'id': userInfoModel.id,
      'firstName': userInfoModel.firstName,
      'lastName': userInfoModel.lastName,
      'email': userInfoModel.email,
      'username': userInfoModel.username,
      'phoneNumber': userInfoModel.phoneNumber,
      'dateOfBirth': userInfoModel.dateOfBirth,
      'gender': userInfoModel.gender == "Male",
    };
  }
}
