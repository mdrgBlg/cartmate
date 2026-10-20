import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '/models/cart_model.dart';
import '/screens/app/home/home_models/products_model.dart';
import '/models/brand_model.dart';
import 'db_constants.dart';
import 'db_helper.dart';

class DbService {
  static Future<void> cartTableExists() async {
    Database db = await DbHelper.database;
    try {
      var tables = await findTable(db, DbConstants.cartTable);
      if (tables.isEmpty) {
        await db.execute('''CREATE TABLE ${DbConstants.cartTable} (
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
        log("Table ${DbConstants.cartTable} is created");
      }
    } catch (e) {
      log("Error creating ${DbConstants.cartTable} table: $e");
    }
  }

  static Future<void> saveCartItem(CartModel cartModel) async {
    Database db = await DbHelper.database;
    try {
      await db.insert(DbConstants.cartTable, {
        'id': cartModel.productModel.id,
        'size': cartModel.size,
        'quantity': cartModel.quantity,
        'brandId': cartModel.productModel.brandModel?.id,
        'categoryId': cartModel.productModel.categoryId,
        'currency': cartModel.productModel.currency,
        'productSize': cartModel.productModel.productSize?.join(',') ?? '',
        'productImage': cartModel.productModel.productImageList.join(','),
        'productName': cartModel.productModel.productName,
        'discount': cartModel.productModel.discount,
        'price': cartModel.productModel.price,
        'stock': cartModel.productModel.stock,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      log("Error saveCartItem: $e");
    }
  }

  static Future<List<CartModel>> loadCart() async {
    List<CartModel> cartItems = [];
    try {
      Database db = await DbHelper.database;
      final List<Map<String, dynamic>> rows = await db.query(
        DbConstants.cartTable,
      );
      for (var row in rows) {
        final brandId = row['brandId'] as String?;
        BrandModel? brandModel;
        if (brandId != null) {
          final brandRows = await db.query(
            DbConstants.brandTable,
            where: 'id = ?',
            whereArgs: [brandId],
          );
          if (brandRows.isNotEmpty) {
            brandModel = BrandModel.fromJsonDb(brandRows.first);
          }
        }
        final ProductsModel? productsModel = ProductsModel.fromDb(
          row,
          brandModel,
        );
        if (productsModel != null) {
          cartItems.add(
            CartModel(
              productModel: productsModel,
              size: row['size'] as String,
              quantity: row['quantity'] as int,
            ),
          );
        }
      }
    } catch (e) {
      log("Error loadCart: $e");
    }
    return cartItems;
  }

  static Future<void> deleteCartItem(String productId, String size) async {
    Database db = await DbHelper.database;
    try {
      await db.delete(
        DbConstants.cartTable,
        where: 'id = ? AND size = ?',
        whereArgs: [productId, size],
      );
    } catch (e) {
      log("Error deleteCartItem: $e");
    }
  }

  static Future<void> clearCart() async {
    Database db = await DbHelper.database;
    try {
      await db.delete(DbConstants.cartTable);
    } catch (e) {
      log("Error clearCart: $e");
    }
  }

  static Future<List<Map<String, Object?>>> findTable(
    Database db,
    String tableName,
  ) async {
    return db.rawQuery('SELECT * FROM sqlite_master WHERE name="$tableName";');
  }
}
