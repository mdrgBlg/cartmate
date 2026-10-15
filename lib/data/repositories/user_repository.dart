import '/models/user_info_model.dart';
import '../models/result.dart';
import '../services/user_service.dart';

class UserRepository {
  UserRepository({required UserService userService})
    : _userService = userService;

  final UserService _userService;

  Future<Result<UserInfoModel>> fetchUserInfo(String userId) =>
      _userService.fetchUserInfo(userId);

  Future<Result<void>> saveUserData(UserInfoModel user) =>
      _userService.saveUserData(user);
}
