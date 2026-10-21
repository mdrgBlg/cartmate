import '/screens/app/checkout/checkout_models/checkout_model.dart';
import '../models/result.dart';
import '../services/api_service.dart';

class OrderRepository {
  OrderRepository({required ApiService apiService}) : _apiService = apiService;

  final ApiService _apiService;

  Future<Result<List<CheckoutModel>>> fetchMyOrders(String userId) =>
      _apiService.fetchMyOrders(userId);
}
