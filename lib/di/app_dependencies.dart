import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '/data/repositories/auth_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/services/auth_service.dart';
import '/data/services/database_service.dart';
import '/data/services/firebase_service.dart';
import '/data/services/user_service.dart';

List<SingleChildWidget> injectServiceDependencies() {
  return [
    Provider(create: (context) => FirebaseService()),
    Provider(create: (context) => DatabaseService()),
    Provider(create: (context) => AuthService(firebaseService: context.read())),
    Provider(create: (context) => UserService(firebaseService: context.read())),
  ];
}

List<SingleChildWidget> injectRepositoryDependencies() {
  return [
    Provider(create: (context) => UserRepository(userService: context.read())),
    Provider(
      create: (context) => AuthRepository(
        firebaseService: context.read(),
        authService: context.read(),
        userService: context.read(),
      ),
    ),
  ];
}
