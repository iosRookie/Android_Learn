// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_packages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowPackageRespond _$FlowPackageRespondFromJson(Map<String, dynamic> json) {
  return FlowPackageRespond(
    json['perPageCount'] as int,
    json['currentPage'] as int,
    json['totalCount'] as int,
    json['totalPageCount'] as int,
    (json['dataList'] as List)
        ?.map((e) =>
            e == null ? null : DataList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FlowPackageRespondToJson(FlowPackageRespond instance) =>
    <String, dynamic>{
      'perPageCount': instance.perPageCount,
      'currentPage': instance.currentPage,
      'totalCount': instance.totalCount,
      'totalPageCount': instance.totalPageCount,
      'dataList': instance.dataList,
    };

DataList _$DataListFromJson(Map<String, dynamic> json) {
  return DataList(
    json['goodsCode'] as String,
    json['goodsId'] as String,
    json['goodsName'] as String,
    json['goodsPrice'] as String,
    json['mccFlag'] as String,
    (json['mccList'] as List)?.map((e) => e as String)?.toList(),
    (json['iso2List'] as List)?.map((e) => e as String)?.toList(),
    json['createTime'] as int,
    json['flowByte'] as double,
    json['period'] as String,
    json['currencyType'] as String,
    json['categoryCode'] as String,
    json['goodsType'] as String,
    json['periodUnit'] as String,
    json['attrMap'] == null
        ? null
        : AttrMap.fromJson(json['attrMap'] as Map<String, dynamic>),
    json['cancelFlag'] as bool,
    json['promotionFlag'] as bool,
    json['promotionActivityCode'] as String,
    json['discountPrice'] as String,
    json['quantity'] as int,
    json['payAgreeFlag'] as String,
    json['deductionInfo'] == null
        ? null
        : DeductionInfo.fromJson(json['deductionInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataListToJson(DataList instance) => <String, dynamic>{
      'goodsCode': instance.goodsCode,
      'goodsId': instance.goodsId,
      'goodsName': instance.goodsName,
      'goodsPrice': instance.goodsPrice,
      'mccFlag': instance.mccFlag,
      'mccList': instance.mccList,
      'iso2List': instance.iso2List,
      'createTime': instance.createTime,
      'flowByte': instance.flowByte,
      'period': instance.period,
      'currencyType': instance.currencyType,
      'categoryCode': instance.categoryCode,
      'goodsType': instance.goodsType,
      'periodUnit': instance.periodUnit,
      'attrMap': instance.attrMap,
      'cancelFlag': instance.cancelFlag,
      'promotionFlag': instance.promotionFlag,
      'promotionActivityCode': instance.promotionActivityCode,
      'discountPrice': instance.discountPrice,
      'quantity': instance.quantity,
      'payAgreeFlag': instance.payAgreeFlag,
      'deductionInfo': instance.deductionInfo,
    };

AttrMap _$AttrMapFromJson(Map<String, dynamic> json) {
  return AttrMap(
    json['payAgreeFlag'] as String,
    json['periodMode'] as String,
    json['period'] as String,
    json['areaFlag'] as String,
    json['infiniFlag'] as String,
    json['effType'] as String,
    json['flowSize'] as String,
    json['timeZone'] as String,
    json['simCardType'] as String,
    json['title'] as String,
    json['periodUnit'] as String,
    json['pkDesc'] as String,
  );
}

Map<String, dynamic> _$AttrMapToJson(AttrMap instance) => <String, dynamic>{
      'payAgreeFlag': instance.payAgreeFlag,
      'periodMode': instance.periodMode,
      'period': instance.period,
      'areaFlag': instance.areaFlag,
      'infiniFlag': instance.infiniFlag,
      'effType': instance.effType,
      'flowSize': instance.flowSize,
      'timeZone': instance.timeZone,
      'simCardType': instance.simCardType,
      'title': instance.title,
      'periodUnit': instance.periodUnit,
      'pkDesc': instance.pkDesc,
    };

DeductionInfo _$DeductionInfoFromJson(Map<String, dynamic> json) {
  return DeductionInfo(
    json['autoRenewFirstPrice'] as int,
    json['autoRenewPrice'] as int,
    json['autoRenewActCode'] as String,
  );
}

Map<String, dynamic> _$DeductionInfoToJson(DeductionInfo instance) =>
    <String, dynamic>{
      'autoRenewFirstPrice': instance.autoRenewFirstPrice,
      'autoRenewPrice': instance.autoRenewPrice,
      'autoRenewActCode': instance.autoRenewActCode,
    };
