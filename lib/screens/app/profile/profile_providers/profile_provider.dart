import 'package:flutter/material.dart';

import '/data/models/auth_exception.dart';
import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/data/repositories/user_repository.dart';
import '/models/user_info_model.dart';
import '/utils/common_utils.dart';
import '/utils/global_enums.dart';
import '../../checkout/checkout_models/checkout_model.dart';
import 'profile_service.dart';

class ProfileProvider with ChangeNotifier {
  ProfileProvider({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository {
    final userInfo = _userRepository.currentUser;

    firstNameController = TextEditingController(text: userInfo?.firstName);
    lastNameController = TextEditingController(text: userInfo?.lastName);
    usernameController = TextEditingController(text: userInfo?.username);
    emailController = TextEditingController(text: userInfo?.email);
    phoneController = TextEditingController(text: userInfo?.phoneNumber);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  List<CheckoutModel> myOrders = [];

  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  String get _userId => _userRepository.currentUser?.id ?? '';
  UserInfoModel? get userInfo => _userRepository.currentUser;

  void setName() {
    _userRepository.updateName(
      firstNameController.text,
      lastNameController.text,
    );
    notifyListeners();
  }

  void setEmail() {
    _userRepository.updateEmail(emailController.text);
    notifyListeners();
  }

  void setUsername() {
    _userRepository.updateUsername(usernameController.text);
    notifyListeners();
  }

  void setPhoneNumber() {
    _userRepository.updatePhoneNumber(phoneController.text);
    notifyListeners();
  }

  void setGender(Gender? value) {
    if (value != null) {
      _userRepository.updateGender(value);
      notifyListeners();
    }
  }

  void setDateOfBirth(DateTime value) {
    _userRepository.updateDateOfBirth(value);
    notifyListeners();
  }

  Future<void> fetchMyOrder(String userId) async {
    myOrders = await ProfileService.fetchMyOrder(userId);
  }

  Future<bool> changeName() => ProfileService.updateUserName(
    _userId,
    firstNameController.text,
    lastNameController.text,
  );

  Future<bool> changeEmail() =>
      ProfileService.updateEmail(_userId, emailController.text);

  Future<bool> changeUsername() =>
      ProfileService.updateUsername(_userId, usernameController.text);

  Future<bool> changePhoneNumber() =>
      ProfileService.updatePhoneNumber(_userId, phoneController.text);

  Future<bool> changeGender(Gender gender) =>
      ProfileService.updateGender(_userId, gender);

  Future<bool> changeDateOfBirth(DateTime value) =>
      ProfileService.updateDateOfBirth(_userId, value.toString());

  Future<AuthErrorType?> signOut() async {
    final result = await _authRepository.signOut();
    if (result case Failure(:final exception)) {
      return fromException(exception);
    }
    return null;
  }
}
