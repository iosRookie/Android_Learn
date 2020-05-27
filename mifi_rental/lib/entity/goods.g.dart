// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goods _$GoodsFromJson(Map<String, dynamic> json) {
  return Goods(
    flowByte: json['flowByte'] as num,
    goodsName: json['goodsName'] as String,
    surplusFlowbyte: json['surplusFlowbyte'] as num,
  );
}

Map<String, dynamic> _$GoodsToJson(Goods instance) => <String, dynamic>{
      'flowByte': instance.flowByte,
      'goodsName': instance.goodsName,
      'surplusFlowbyte': instance.surplusFlowbyte,
    };
