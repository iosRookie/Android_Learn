// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
    depositAmount: json['depositAmount'] as String,
    currencyType: json['currencyType'] as String,
    orderType: json['orderType'] as String,
    maxRentDay: json['maxRentDay'] as String,
    salePrice: json['salePrice'] as String,
    channelType: json['channelType'] as String,
    perHourPrice: json['perHourPrice'] as String,
    freeUseTime: json['freeUseTime'] as String,
    dayMaxPrice: json['dayMaxPrice'] as String,
  );
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'depositAmount': instance.depositAmount,
      'currencyType': instance.currencyType,
      'orderType': instance.orderType,
      'maxRentDay': instance.maxRentDay,
      'salePrice': instance.salePrice,
      'channelType': instance.channelType,
      'perHourPrice': instance.perHourPrice,
      'freeUseTime': instance.freeUseTime,
      'dayMaxPrice': instance.dayMaxPrice,
    };
