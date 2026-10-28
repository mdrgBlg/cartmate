import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/order_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/models/checkout_model.dart';

class MyOrdersProvider with ChangeNotifier {
  MyOrdersProvider({
    required OrderRepository orderRepository,
    required UserRepository userRepository,
  }) : _orderRepository = orderRepository,
       _userRepository = userRepository {
    _myOrdersFuture = _fetchMyOrders();
  }

  final OrderRepository _orderRepository;
  final UserRepository _userRepository;

  late final Future<void> _myOrdersFuture;
  Future<void> get myOrdersFuture => _myOrdersFuture;

  Exception? _error;
  bool get hasError => _error != null;

  List<CheckoutModel> _myOrders = [];
  List<CheckoutModel> get myOrders => _myOrders;

  // Started once from the constructor and awaited by `MyOrdersScreen`'s
  // `FutureBuilder`, which owns the loading state.
  Future<void> _fetchMyOrders() async {
    _error = null;

    final userId = _userRepository.currentUser?.id;
    if (userId == null) {
      _myOrders = [];
      _error = Exception('No current user');
      return;
    }

    final result = await _orderRepository.fetchMyOrders(userId);
    switch (result) {
      case Success(:final data):
        _myOrders = data;
      case Failure(:final exception):
        _myOrders = [];
        _error = exception;
    }
    notifyListeners();
  }
}
