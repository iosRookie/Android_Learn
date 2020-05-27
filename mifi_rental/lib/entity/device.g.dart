// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    mvnoCode: json['mvnoCode'] as String,
    mifiSn: json['mifiSn'] as String,
    mifiImei: json['mifiImei'] as String,
    terminalSn: json['terminalSn'] as String,
    slotIndex: json['slotIndex'] as String,
    softVersion: json['softVersion'] as String,
    wifiName: json['wifiName'] as String,
    wifiPwd: json['wifiPwd'] as String,
    battery: json['battery'] as String,
    mifiStatus: json['mifiStatus'] as String,
    wifiStatus: json['wifiStatus'] as String,
    netStatus: json['netStatus'] as String,
    createTm: json['createTm'] as num,
    updateTm: json['updateTm'] as num,
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'mvnoCode': instance.mvnoCode,
      'mifiSn': instance.mifiSn,
      'mifiImei': instance.mifiImei,
      'terminalSn': instance.terminalSn,
      'slotIndex': instance.slotIndex,
      'softVersion': instance.softVersion,
      'wifiName': instance.wifiName,
      'wifiPwd': instance.wifiPwd,
      'battery': instance.battery,
      'mifiStatus': instance.mifiStatus,
      'wifiStatus': instance.wifiStatus,
      'netStatus': instance.netStatus,
      'createTm': instance.createTm,
      'updateTm': instance.updateTm,
    };
