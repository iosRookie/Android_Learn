import 'package:mifi_rental/db/db_manager.dart';
import 'package:mifi_rental/entity/goods.dart';

class GoodsDb extends DbProvider {
  @override
  createTableSql() {
    return 'CREATE TABLE IF NOT EXISTS ${tableName()}(_id INTEGER PRIMARY KEY AUTOINCREMENT, flowByte DOUBLE, goodsName TEXT, surplusFlowbyte DOUBLE)';
  }

  @override
  tableName() {
    return 'goods';
  }

  insert(Goods goods) async {
    var db = await getDataBase();
    return await db.insert(tableName(), _toMap(goods));
  }

  Future<Goods> query() async {
    var db = await getDataBase();
    List<Map> list = await db.rawQuery('select * from ${tableName()} limit 1');
    var mList = list.map((i) => _toGoods(i)).toList();
    if (mList.isNotEmpty) {
      return mList[0];
    }
    return null;
  }

  update(Goods goods) async {
    var db = await getDataBase();
    await db.delete(tableName());
    return await db.insert(tableName(), _toMap(goods));
  }

  deleteAll() async {
    var db = await getDataBase();
    return await db.delete(tableName());
  }

  Map<String, dynamic> _toMap(Goods goods) {
    return goods.toJson();
  }

  Goods _toGoods(Map map) {
    return Goods.fromJson(map);
  }
}
