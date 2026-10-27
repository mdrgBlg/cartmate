import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService({String? databaseName, int? version})
    : _databaseName = databaseName ?? dbName,
      _version = version ?? dbVersion;

  static const dbName = 'e_commerce.db';
  static const dbVersion = 1;

  final String _databaseName;
  final int _version;
  Database? _database;

  Future<Database> get database async {
    return _database ??= await _open();
  }

  Future<void> init() async {
    await database;
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: _version);
  }
}
