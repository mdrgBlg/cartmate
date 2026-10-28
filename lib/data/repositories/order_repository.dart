import '/data/models/checkout_model.dart';
import '../models/result.dart';
import '../services/order_service.dart';

class OrderRepository {
  OrderRepository({required OrderService orderService})
    : _orderService = orderService;

  final OrderService _orderService;

  Future<Result<List<CheckoutModel>>> fetchMyOrders(String userId) =>
      _orderService.fetchOrders(userId);

  Future<Result<void>> saveOrder(CheckoutModel order) =>
      _orderService.saveOrder(order);
}
