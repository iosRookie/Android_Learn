// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Popup _$PopupFromJson(Map<String, dynamic> json) {
  return Popup(
    mvnoCode: json['mvnoCode'] as String,
    orderSn: json['orderSn'] as String,
    terminalSn: json['terminalSn'] as String,
    mifiImei: json['mifiImei'] as String,
    slotIndex: json['slotIndex'] as String,
    popStatus: json['popStatus'] as num,
  );
}

Map<String, dynamic> _$PopupToJson(Popup instance) => <String, dynamic>{
      'mvnoCode': instance.mvnoCode,
      'orderSn': instance.orderSn,
      'terminalSn': instance.terminalSn,
      'mifiImei': instance.mifiImei,
      'slotIndex': instance.slotIndex,
      'popStatus': instance.popStatus,
    };
