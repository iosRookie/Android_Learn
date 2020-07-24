import 'package:json_annotation/json_annotation.dart';

part 'flow_packages.g.dart';


@JsonSerializable()
class FlowPackageRespond extends Object {

  @JsonKey(name: 'perPageCount')
  int perPageCount;

  @JsonKey(name: 'currentPage')
  int currentPage;

  @JsonKey(name: 'totalCount')
  int totalCount;

  @JsonKey(name: 'totalPageCount')
  int totalPageCount;

  @JsonKey(name: 'dataList')
  List<DataList> dataList;

  FlowPackageRespond(this.perPageCount,this.currentPage,this.totalCount,this.totalPageCount,this.dataList,);

  factory FlowPackageRespond.fromJson(Map<String, dynamic> srcJson) => _$FlowPackageRespondFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FlowPackageRespondToJson(this);

}


@JsonSerializable()
class DataList extends Object {

  @JsonKey(name: 'goodsCode')
  String goodsCode;

  @JsonKey(name: 'goodsId')
  String goodsId;

  @JsonKey(name: 'goodsName')
  String goodsName;

  @JsonKey(name: 'goodsPrice')
  String goodsPrice;

  @JsonKey(name: 'mccFlag')
  String mccFlag;

  @JsonKey(name: 'mccList')
  List<String> mccList;

  @JsonKey(name: 'iso2List')
  List<String> iso2List;

  @JsonKey(name: 'createTime')
  int createTime;

  @JsonKey(name: 'flowByte')
  double flowByte;

  @JsonKey(name: 'period')
  String period;

  @JsonKey(name: 'currencyType')
  String currencyType;

  @JsonKey(name: 'categoryCode')
  String categoryCode;

  @JsonKey(name: 'goodsType')
  String goodsType;

  @JsonKey(name: 'periodUnit')
  String periodUnit;

  @JsonKey(name: 'attrMap')
  AttrMap attrMap;

  @JsonKey(name: 'cancelFlag')
  bool cancelFlag;

  @JsonKey(name: 'promotionFlag')
  bool promotionFlag;

  @JsonKey(name: 'promotionActivityCode')
  String promotionActivityCode;

  @JsonKey(name: 'discountPrice')
  String discountPrice;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'payAgreeFlag')
  String payAgreeFlag;

  @JsonKey(name: 'deductionInfo')
  DeductionInfo deductionInfo;

  DataList(this.goodsCode,this.goodsId,this.goodsName,this.goodsPrice,this.mccFlag,this.mccList,this.iso2List,this.createTime,this.flowByte,this.period,this.currencyType,this.categoryCode,this.goodsType,this.periodUnit,this.attrMap,this.cancelFlag,this.promotionFlag,this.promotionActivityCode,this.discountPrice,this.quantity,this.payAgreeFlag,this.deductionInfo,);

  factory DataList.fromJson(Map<String, dynamic> srcJson) => _$DataListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataListToJson(this);

}


@JsonSerializable()
class AttrMap extends Object {

  @JsonKey(name: 'payAgreeFlag')
  String payAgreeFlag;

  @JsonKey(name: 'periodMode')
  String periodMode;

  @JsonKey(name: 'period')
  String period;

  @JsonKey(name: 'areaFlag')
  String areaFlag;

  @JsonKey(name: 'infiniFlag')
  String infiniFlag;

  @JsonKey(name: 'effType')
  String effType;

  @JsonKey(name: 'flowSize')
  String flowSize;

  @JsonKey(name: 'timeZone')
  String timeZone;

  @JsonKey(name: 'simCardType')
  String simCardType;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'periodUnit')
  String periodUnit;

  @JsonKey(name: 'pkDesc')
  String pkDesc;

  AttrMap(this.payAgreeFlag,this.periodMode,this.period,this.areaFlag,this.infiniFlag,this.effType,this.flowSize,this.timeZone,this.simCardType,this.title,this.periodUnit,this.pkDesc,);

  factory AttrMap.fromJson(Map<String, dynamic> srcJson) => _$AttrMapFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AttrMapToJson(this);

}


@JsonSerializable()
class DeductionInfo extends Object {

  @JsonKey(name: 'autoRenewFirstPrice')
  int autoRenewFirstPrice;

  @JsonKey(name: 'autoRenewPrice')
  int autoRenewPrice;

  @JsonKey(name: 'autoRenewActCode')
  String autoRenewActCode;

  DeductionInfo(this.autoRenewFirstPrice,this.autoRenewPrice,this.autoRenewActCode,);

  factory DeductionInfo.fromJson(Map<String, dynamic> srcJson) => _$DeductionInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeductionInfoToJson(this);

}


