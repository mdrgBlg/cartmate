import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '/db/db_constants.dart';
import '/models/brand_model.dart';
import '/screens/app/home/home_models/products_model.dart';
import '../models/result.dart';
import 'database_service.dart';

class WishlistService {
  WishlistService({required DatabaseService databaseService})
    : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<Result<List<ProductsModel>>> fetchWishlistProducts() async {
    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      final rows = await db.query(DbConstants.whishlistTable);
      final products = <ProductsModel>[];
      for (final row in rows) {
        BrandModel? brand;
        final brandId = row['brandId'] as String?;
        if (brandId != null) {
          final brandRows = await db.query(
            DbConstants.brandTable,
            where: 'id = ?',
            whereArgs: [brandId],
          );
          if (brandRows.isNotEmpty) {
            brand = BrandModel.fromJsonDb(brandRows.first);
          }
        }
        products.add(ProductsModel.fromDb(row, brand));
      }
      return Success(products);
    } catch (e) {
      log("Exception fetchWishlistProducts: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> addProduct(ProductsModel product) async {
    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      final brand = product.brandModel;
      if (brand != null) {
        await db.insert(
          DbConstants.brandTable,
          brand.brandToMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
      final rowId = await db.insert(
        DbConstants.whishlistTable,
        product.productToMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (rowId == -1) {
        return Failure(Exception('Insert failed'));
      }
      return const Success<void>(null);
    } catch (e) {
      log("Exception addProduct: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> removeProduct(String productId) async {
    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      await db.delete(
        DbConstants.whishlistTable,
        where: 'id = ?',
        whereArgs: [productId],
      );
      return const Success<void>(null);
    } catch (e) {
      log("Exception removeProduct: $e");
      return Failure(Exception(e));
    }
  }

  Future<void> _ensureTables(Database db) async {
    await db.execute(
      '''CREATE TABLE IF NOT EXISTS ${DbConstants.whishlistTable} (
      id TEXT PRIMARY KEY,
      brandId TEXT,
      categoryId TEXT,
      currency TEXT,
      productSize TEXT,
      productImage TEXT,
      productName TEXT,
      discount INTEGER,
      price INTEGER,
      stock INTEGER,
      wishlist INTEGER
      )''',
    );
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DbConstants.brandTable} (
      id TEXT PRIMARY KEY,
      brandName TEXT,
      iconName TEXT,
      productCount INTEGER
      )''');
  }
}
