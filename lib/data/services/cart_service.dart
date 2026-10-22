import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '/models/brand_model.dart';
import '/models/cart_model.dart';
import '/models/products_model.dart';
import '/utils/constants/db_constants.dart';
import '../models/result.dart';
import 'database_service.dart';

class CartService {
  CartService({required DatabaseService databaseService})
    : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<Result<List<CartModel>>> fetchCart() async {
    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      final rows = await db.query(DbConstants.cartTable, orderBy: 'rowid');
      final items = <CartModel>[];
      for (final row in rows) {
        try {
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
          final product = ProductsModel.fromDb(<String, dynamic>{
            ...row,
            'wishlist': 0,
          }, brand);
          items.add(
            CartModel(
              productModel: product,
              size: row['size'] as String,
              quantity: row['quantity'] as int,
            ),
          );
        } catch (e) {
          log("Skipped unreadable cart row: $e");
        }
      }
      return Success(items);
    } catch (e) {
      log("Exception fetchCart: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> saveItem(CartModel item) async {
    // Snapshot before the first await so the write reflects the quantity at
    // call time even when the user taps faster than the database.
    final product = item.productModel;
    final row = <String, Object?>{
      'id': product.id,
      'size': item.size,
      'quantity': item.quantity,
      'brandId': product.brandModel?.id,
      'categoryId': product.categoryId,
      'currency': product.currency,
      'productSize': product.productSize?.join(',') ?? '',
      'productImage': product.productImageList.join(','),
      'productName': product.productName,
      'discount': product.discount,
      'price': product.price,
      'stock': product.stock,
    };
    final brand = product.brandModel?.brandToMap();

    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      if (brand != null) {
        await db.insert(
          DbConstants.brandTable,
          brand,
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
      // Update first so an existing line keeps its position in the table.
      final updated = await db.update(
        DbConstants.cartTable,
        {'quantity': row['quantity']},
        where: 'id = ? AND size = ?',
        whereArgs: [row['id'], row['size']],
      );
      if (updated == 0) {
        final rowId = await db.insert(
          DbConstants.cartTable,
          row,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        if (rowId == -1) {
          return Failure(Exception('Insert failed'));
        }
      }
      return const Success<void>(null);
    } catch (e) {
      log("Exception saveItem: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> deleteItem(CartModel item) async {
    final productId = item.productModel.id;
    final size = item.size;

    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      await db.delete(
        DbConstants.cartTable,
        where: 'id = ? AND size = ?',
        whereArgs: [productId, size],
      );
      return const Success<void>(null);
    } catch (e) {
      log("Exception deleteItem: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> clearCart() async {
    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      await db.delete(DbConstants.cartTable);
      return const Success<void>(null);
    } catch (e) {
      log("Exception clearCart: $e");
      return Failure(Exception(e));
    }
  }

  Future<void> _ensureTables(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DbConstants.cartTable} (
      id TEXT,
      size TEXT,
      quantity INTEGER,
      brandId TEXT,
      categoryId TEXT,
      currency TEXT,
      productSize TEXT,
      productImage TEXT,
      productName TEXT,
      discount INTEGER,
      price INTEGER,
      stock INTEGER,
      PRIMARY KEY (id, size)
      )''');
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DbConstants.brandTable} (
      id TEXT PRIMARY KEY,
      brandName TEXT,
      iconName TEXT,
      productCount INTEGER
      )''');
  }
}
