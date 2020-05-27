import 'dart:collection';

import 'package:core_log/core_log.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {
  static DbManager get singleton => _getInstance();

  static DbManager _getInstance() {
    if (_instance == null) {
      _instance = new DbManager._internal();
    }
    return _instance;
  }

  static DbManager _instance;

  DbManager._internal();

  static const DB_NAME = 'wifi_rental.db';
  static const DB_VERSION = 1;

  Database _db;

  HashSet<String> _tables = HashSet();

  _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    _db = await openDatabase(path, version: DB_VERSION,
        onCreate: (Database db, int version) async {
      ULog.i("open database :$DB_NAME version:$DB_VERSION");
    });
  }

  Future<Database> getDatabase() async {
    if (_db == null) {
      await _init();
    }
    return _db;
  }

  close() {
    _db?.close();
    _db = null;
  }

  createTable(String tableName, String sql) async {
    if (!_tables.contains(tableName)) {
      var db = await getDatabase();
      db.execute(sql);
      _tables.add(tableName);
    }
  }
}

abstract class DbProvider {
  tableName();

  createTableSql();

  Future<Database> getDataBase() async {
    await DbManager.singleton.createTable(tableName(), createTableSql());
    return await DbManager.singleton.getDatabase();
  }
}
