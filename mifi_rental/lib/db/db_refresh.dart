import 'package:mifi_rental/entity/refresh.dart';

import 'db_manager.dart';

class RefreshDb extends DbProvider {
  @override
  createTableSql() {
    return 'CREATE TABLE IF NOT EXISTS ${tableName()}(_id INTEGER PRIMARY KEY AUTOINCREMENT, date Text)';
  }

  @override
  tableName() {
    return 'Refresh';
  }

  insert(Refresh refresh) async {
    var db = await getDataBase();
    await db.delete(tableName());
    return await db.insert(tableName(), refresh.toJson());
  }

  deleteAll() async {
    var db = await getDataBase();
    return await db.delete(tableName());
  }

  Future<Refresh> query() async {
    var db = await getDataBase();
    List<Map> list = await db.rawQuery('select * from ${tableName()} limit 1');
    var mList = list.map((i) => Refresh.fromJson(i)).toList();
    if (mList.isNotEmpty) {
      return mList[0];
    }
    return null;
  }
}
