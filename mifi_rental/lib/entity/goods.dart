import 'package:json_annotation/json_annotation.dart';

part 'goods.g.dart';

@JsonSerializable(nullable: false)
class Goods {
  num flowByte;
  String goodsName;
  num surplusFlowbyte;

  Goods({this.flowByte, this.goodsName, this.surplusFlowbyte});

  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsToJson(this);
}
