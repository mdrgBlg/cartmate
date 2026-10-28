import '/utils/global_enums.dart';

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
    dateOfBirth: DateTime.parse(json["dateOfBirth"] as String),
    gender: json["gender"] == true ? Gender.male : Gender.female,
  );

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final Gender gender;

  String get fullName => "${firstName} ${lastName}";

  UserInfoModel copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? phoneNumber,
    DateTime? dateOfBirth,
    Gender? gender,
  }) => UserInfoModel(
    id: id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email,
    username: username ?? this.username,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    gender: gender ?? this.gender,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toString(),
      'gender': gender == Gender.male,
    };
  }
}
