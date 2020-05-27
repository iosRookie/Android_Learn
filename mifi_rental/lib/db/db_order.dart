import 'package:core_log/core_log.dart';
import 'package:mifi_rental/entity/order.dart';

import 'db_manager.dart';

class OrderDb extends DbProvider {
  @override
  createTableSql() {
    return 'CREATE TABLE IF NOT EXISTS ${tableName()}(orderSn TEXT PRIMARY KEY, mvnoCode TEXT, terminalSn TEXT, mifiImei TEXT, customerId TEXT, rentTm DOUBLE, returnTm DOUBLE, usedTmStr TEXT, currencyCode TEXT, deposit DOUBLE, shouldPay DOUBLE, actuallyPay DOUBLE, payStatus TEXT, returnStatus TEXT, saleStatus TEXT, orderStatus TEXT, canPopup INTEGER, createTm DOUBLE, updateTm DOUBLE)';
  }

  @override
  tableName() {
    return 'OrderInfo';
  }

  insert(Order order) async {
    var db = await getDataBase();
    return await db.insert(tableName(), toMap(order));
  }

  Future<Order> query() async {
    var db = await getDataBase();
    List<Map> list = await db.rawQuery('select * from ${tableName()} limit 1');
    var mList = list.map((i) => toOrder(i)).toList();
    ULog.d('查询订单' + mList.toString());
    if (mList.isNotEmpty) {
      return mList[0];
    }
    return null;
  }

  update(Order order) async {
    var db = await getDataBase();
    ULog.d('更新订单' + order.toString());
    return await db.update(tableName(), toMap(order));
  }

  void deleteAll() async {
    ULog.d('清空订单');
    var db = await getDataBase();
    await db.delete(tableName());
  }

  Map<String, dynamic> toMap(Order order) {
    return order.toJson();
  }

  Order toOrder(Map map) {
    return Order.fromJson(map);
  }
}
