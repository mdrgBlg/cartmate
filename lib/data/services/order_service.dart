import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '/models/checkout_model.dart';
import '/utils/constants/db_constants.dart';
import '../models/result.dart';
import 'database_service.dart';

class OrderService {
  OrderService({required DatabaseService databaseService})
    : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<Result<void>> saveOrder(CheckoutModel order) async {
    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      final rowId = await db.insert(DbConstants.ordersTable, order.toDbMap());
      if (rowId == -1) {
        return Failure(Exception('Insert failed'));
      }
      return const Success<void>(null);
    } catch (e) {
      log("Exception saveOrder: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<List<CheckoutModel>>> fetchOrders(String userId) async {
    try {
      final db = await _databaseService.database;
      await _ensureTables(db);

      final rows = await db.query(
        DbConstants.ordersTable,
        where: 'userId = ?',
        whereArgs: [userId],
        orderBy: 'id DESC',
      );
      final orders = <CheckoutModel>[];
      for (final row in rows) {
        try {
          orders.add(CheckoutModel.fromDb(row));
        } catch (e) {
          log("Skipped unreadable order row: $e");
        }
      }
      return Success(orders);
    } catch (e) {
      log("Exception fetchOrders: $e");
      return Failure(Exception(e));
    }
  }

  Future<void> _ensureTables(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DbConstants.ordersTable} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      orderId TEXT,
      userId TEXT,
      address TEXT,
      city TEXT,
      country TEXT,
      email TEXT,
      firstName TEXT,
      lastName TEXT,
      checkoutPrice REAL,
      postalCode INTEGER,
      items TEXT,
      deliveryDate TEXT,
      orderDate TEXT,
      orderStatus INTEGER
      )''');
  }
}
