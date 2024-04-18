import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import 'db_constants.dart';
import 'db_helper.dart';

class DbService {
  static Future<void> whishlistTableExists() async {
    Database db = await DbHelper.database;
    try {
      var tables = await findTable(db, DbConstants.whishlistTable);
      if (tables.isEmpty) {
        await db.execute(
          '''CREATE TABLE ${DbConstants.whishlistTable} (
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
        log("Table ${DbConstants.whishlistTable} is created");
      }
    } catch (e) {
      log("Error creating ${DbConstants.whishlistTable} table: $e");
    }
  }

  static Future<void> brandTableExists() async {
    Database db = await DbHelper.database;
    try {
      var tables = await findTable(db, DbConstants.brandTable);
      if (tables.isEmpty) {
        await db.execute(
          '''CREATE TABLE ${DbConstants.brandTable} (
      id TEXT PRIMARY KEY,
      brandName TEXT,
      iconName TEXT,
      productCount INTEGER
      )''',
        );
        log("Table ${DbConstants.brandTable} is created");
      }
    } catch (e) {
      log("Error creating ${DbConstants.brandTable} table: $e");
    }
  }

  static Future<bool> doesBrandExist(String brandId) async {
    Database db = await DbHelper.database;
    final results = await db.query(
      DbConstants.brandTable,
      where: 'id = ?',
      whereArgs: [brandId],
    );
    return results.isNotEmpty;
  }

  static Future<List<Map<String, Object?>>> findTable(Database db, String tableName) async {
    return db.rawQuery('SELECT * FROM sqlite_master WHERE name="$tableName";');
  }
}
