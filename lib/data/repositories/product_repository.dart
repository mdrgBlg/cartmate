import '/models/brand_model.dart';
import '/screens/app/home/home_models/categories_model.dart';
import '/screens/app/home/home_models/products_model.dart';
import '../models/result.dart';
import '../services/api_service.dart';

class ProductRepository {
  ProductRepository({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  Future<Result<List<ProductsModel>>> fetchProducts() =>
      _apiService.fetchProducts();

  Future<Result<List<CategoriesModel>>> fetchCategories() =>
      _apiService.fetchCategories();

  Future<Result<List<BrandModel>>> fetchBrands() => _apiService.fetchBrands();
}
