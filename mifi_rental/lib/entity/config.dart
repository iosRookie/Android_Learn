import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable(nullable: false)
class Config {
  String depositAmount;
  String currencyType;
  String orderType;
  String maxRentDay;
  String salePrice;
  String channelType;
  String perHourPrice;
  String freeUseTime;
  String dayMaxPrice;

  Config({this.depositAmount,
    this.currencyType,
    this.orderType,
    this.maxRentDay,
    this.salePrice,
    this.channelType,
    this.perHourPrice,
    this.freeUseTime,
    this.dayMaxPrice});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
