import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '/data/repositories/auth_repository.dart';
import '/data/repositories/cart_repository.dart';
import '/data/repositories/order_repository.dart';
import '/data/repositories/product_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/data/services/firestore_service.dart';
import '/data/services/auth_service.dart';
import '/data/services/cart_service.dart';
import '/data/services/database_service.dart';
import '/data/services/firebase_service.dart';
import '/data/services/order_service.dart';
import '/data/services/wishlist_service.dart';

List<SingleChildWidget> injectServiceDependencies() {
  return [
    Provider(create: (context) => FirebaseService()),
    Provider(create: (context) => DatabaseService()),
    Provider(create: (context) => AuthService(firebaseService: context.read())),
    Provider(
      create: (context) => FirestoreService(firebaseService: context.read()),
    ),
    Provider(
      create: (context) => WishlistService(firebaseService: context.read()),
    ),
    Provider(
      create: (context) => OrderService(firebaseService: context.read()),
    ),
    Provider(create: (context) => CartService(databaseService: context.read())),
  ];
}

List<SingleChildWidget> injectRepositoryDependencies() {
  return [
    ChangeNotifierProvider(
      create: (context) => UserRepository(firestoreService: context.read()),
    ),
    Provider(
      create: (context) => OrderRepository(orderService: context.read()),
    ),
    Provider(
      create: (context) => ProductRepository(firestoreService: context.read()),
    ),
    ChangeNotifierProvider(
      create: (context) => WishlistRepository(wishlistService: context.read()),
    ),
    ChangeNotifierProvider(
      create: (context) => CartRepository(cartService: context.read()),
    ),
    Provider(
      create: (context) => AuthRepository(
        firebaseService: context.read(),
        authService: context.read(),
        firestoreService: context.read(),
      ),
    ),
  ];
}
