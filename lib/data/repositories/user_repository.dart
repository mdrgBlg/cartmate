import '/models/user_info_model.dart';
import '../models/result.dart';
import '../services/user_service.dart';

class UserRepository {
  UserRepository({required UserService userService})
    : _userService = userService;

  final UserService _userService;

  UserInfoModel? _currentUser;

  UserInfoModel? get currentUser => _currentUser;

  /// Fetches the profile and caches it as the current user on success.
  Future<Result<UserInfoModel>> fetchUserInfo(String userId) async {
    final result = await _userService.fetchUserInfo(userId);
    if (result case Success(:final data)) {
      _currentUser = data;
    }
    return result;
  }

  Future<Result<void>> saveUserData(UserInfoModel user) =>
      _userService.saveUserData(user);

  void setCurrentUser(UserInfoModel? user) {
    _currentUser = user;
  }

  void updateName(String firstName, String lastName) {
    _currentUser?.firstName = firstName;
    _currentUser?.lastName = lastName;
  }

  void updateEmail(String value) {
    _currentUser?.email = value;
  }

  void updateUsername(String value) {
    _currentUser?.username = value;
  }

  void updatePhoneNumber(String value) {
    _currentUser?.phoneNumber = value;
  }

  void updateGender(String? value) {
    _currentUser?.gender = value ?? '';
  }

  void updateDateOfBirth(String? value) {
    _currentUser?.dateOfBirth = value ?? '';
  }

  /// In-memory only.
  void clearCurrentUser() {
    _currentUser = null;
  }
}
