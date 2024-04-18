import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const dbName = "e_commerce.db";
  static const dbVersion = 1;

  static Database? db;

  static Future get database async {
    if (db != null) return db;
    db = await initDB();
    return db;
  }

  static Future<Database> initDB() async {
    String path = join(
      await getDatabasesPath(),
      dbName,
    );
    return await openDatabase(
      path,
      version: dbVersion,
    );
  }
}
