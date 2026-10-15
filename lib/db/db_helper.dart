import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '/data/services/database_service.dart';

// TODO: remove when DbService/HomeService are migrated to DatabaseService
class DbHelper {
  static const dbName = DatabaseService.dbName;
  static const dbVersion = DatabaseService.dbVersion;

  static Database? db;

  /// TODO
  static Future<Database> get database async {
    if (db != null) {
      return db!;
    }
    db = await initDB();
    return db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: dbVersion);
  }
}
