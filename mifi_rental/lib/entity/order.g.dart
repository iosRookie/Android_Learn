// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    mvnoCode: json['mvnoCode'] as String,
    terminalSn: json['terminalSn'] as String,
    orderSn: json['orderSn'] as String,
    mifiImei: json['mifiImei'] as String,
    customerId: json['customerId'] as String,
    rentTm: json['rentTm'] as num,
    returnTm: json['returnTm'] as num,
    usedTmStr: json['usedTmStr'] as String,
    currencyCode: json['currencyCode'] as String,
    deposit: json['deposit'] as num,
    shouldPay: json['shouldPay'] as num,
    actuallyPay: json['actuallyPay'] as num,
    payStatus: json['payStatus'] as String,
    returnStatus: json['returnStatus'] as String,
    saleStatus: json['saleStatus'] as String,
    orderStatus: json['orderStatus'] as String,
    canPopup: json['canPopup'] as num,
    createTm: json['createTm'] as num,
    updateTm: json['updateTm'] as num,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'mvnoCode': instance.mvnoCode,
      'terminalSn': instance.terminalSn,
      'orderSn': instance.orderSn,
      'mifiImei': instance.mifiImei,
      'customerId': instance.customerId,
      'rentTm': instance.rentTm,
      'returnTm': instance.returnTm,
      'usedTmStr': instance.usedTmStr,
      'currencyCode': instance.currencyCode,
      'deposit': instance.deposit,
      'shouldPay': instance.shouldPay,
      'actuallyPay': instance.actuallyPay,
      'payStatus': instance.payStatus,
      'returnStatus': instance.returnStatus,
      'saleStatus': instance.saleStatus,
      'orderStatus': instance.orderStatus,
      'canPopup': instance.canPopup,
      'createTm': instance.createTm,
      'updateTm': instance.updateTm,
    };
