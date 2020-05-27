import 'package:core_log/core_log.dart';
import 'package:mifi_rental/entity/device.dart';

import 'db_manager.dart';

class DeviceDb extends DbProvider {
  @override
  createTableSql() {
    return 'CREATE TABLE IF NOT EXISTS ${tableName()}(_id INTEGER PRIMARY KEY AUTOINCREMENT, mvnoCode TEXT, mifiSn TEXT, mifiImei TEXT, terminalSn TEXT, slotIndex TEXT, softVersion TEXT, wifiName TEXT, wifiPwd TEXT, battery TEXT, mifiStatus TEXT, wifiStatus TEXT, netStatus TEXT, createTm DOUBLE, updateTm DOUBLE)';
  }

  @override
  tableName() {
    return 'device';
  }

  insert(Device device) async {
    ULog.d('添加设备' + device.toString());
    var db = await getDataBase();
    return await db.insert(tableName(), _toMap(device));
  }

  Future<Device> query() async {
    var db = await getDataBase();
    List<Map> list = await db.rawQuery('select * from ${tableName()} limit 1');
    var mList = list.map((i) => _toDevice(i)).toList();
    ULog.d('查询设备' + mList.toString());
    if (mList.isNotEmpty) {
      return mList[0];
    }
    return null;
  }

  update(Device device) async {
    ULog.d('跟新设备' + device.toString());
    var db = await getDataBase();
    await db.delete(tableName());
    return await db.insert(tableName(), _toMap(device));
  }

  deleteAll() async {
    ULog.d('清空设备');
    var db = await getDataBase();
    return await db.delete(tableName());
  }

  Map<String, dynamic> _toMap(Device device) {
    return device.toJson();
  }

  Device _toDevice(Map map) {
    return Device.fromJson(map);
  }
}
