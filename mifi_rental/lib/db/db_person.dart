import 'dart:collection';


import 'package:mifi_rental/entity/person.dart';

import 'db_manager.dart';

class PersonDb extends DbProvider {
  @override
  createTableSql() {
    return 'CREATE TABLE IF NOT EXISTS ${tableName()}(id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, lastName TEXT)';
  }

  @override
  tableName() {
    return 'Person';
  }

  insert(Person person) async {
    var db = await getDataBase();
    return await db.insert(tableName(), toMap(person));
  }

  Future<List<Person>> queryAll() async {
    var db = await getDataBase();
    List<Map> list = await db.query(tableName());
    return list.map((i) => toPerson(i)).toList();
  }

  Map<String, dynamic> toMap(Person person) {
    HashMap<String, dynamic> map = new HashMap();
    map["firstName"] = person.firstName;
    map['lastName'] = person.lastName;
    return map;
  }

  Person toPerson(Map map) {
    return Person(firstName: map["firstName"], lastName: map['lastName']);
  }
}