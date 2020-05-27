import 'dart:collection';

import 'package:mifi_rental/entity/user.dart';

import 'db_manager.dart';

class UserDb extends DbProvider {
  @override
  createTableSql() {
    return 'CREATE TABLE IF NOT EXISTS ${tableName()}(loginCustomerId TEXT PRIMARY KEY)';
  }

  @override
  tableName() {
    return 'User';
  }

  insert(User user) async {
    var db = await getDataBase();
    return await db.insert(tableName(), user.toJson());
  }

  Future<User> query() async {
    var db = await getDataBase();
    List<Map> list = await db.rawQuery('select * from ${tableName()} limit 1');
    var userList = list.map((i) => User.fromJson(i)).toList();
    if (userList.isNotEmpty) {
      return userList[0];
    }
    return null;
  }
}
