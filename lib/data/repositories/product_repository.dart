import '/data/models/brand_model.dart';
import '/data/models/categories_model.dart';
import '/data/models/products_model.dart';
import '../models/result.dart';
import '../services/firestore_service.dart';

/// Single shared instance (registered in DI) and the in-memory source of truth
/// for the catalog (products, categories, brands).
///
/// Returns cached data when available, otherwise fetches it. Failures are not
/// cached so the next call retries.
class ProductRepository {
  ProductRepository({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;

  List<ProductsModel>? _products;
  List<CategoriesModel>? _categories;
  List<BrandModel>? _brands;

  Future<Result<List<ProductsModel>>> getProducts() async {
    final products = _products;
    if (products != null) {
      return Success(products);
    }

    final result = await _firestoreService.fetchProducts();
    if (result case Success(:final data)) {
      _products = data;
    }
    return result;
  }

  Future<Result<List<CategoriesModel>>> getCategories() async {
    final categories = _categories;
    if (categories != null) {
      return Success(categories);
    }

    final result = await _firestoreService.fetchCategories();
    if (result case Success(:final data)) {
      _categories = data;
    }
    return result;
  }

  Future<Result<List<BrandModel>>> fetchBrands() async {
    final brands = _brands;
    if (brands != null) {
      return Success(brands);
    }

    final result = await _firestoreService.fetchBrands();
    if (result case Success(:final data)) {
      _brands = data;
    }
    return result;
  }
}
