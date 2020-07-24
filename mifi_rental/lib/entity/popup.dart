import 'package:json_annotation/json_annotation.dart';

part 'popup.g.dart';

@JsonSerializable(nullable: false)
class Popup {
  String mvnoCode;
  String orderSn; //订单编号
  String terminalSn; //机柜编码
  String mifiImei; //mifi imei码
  String slotIndex; //弹出孔位
  num popResult; //弹出状态  0-失败，1-成功 2-弹机中

  Popup(
      {this.mvnoCode,
      this.orderSn,
      this.terminalSn,
      this.mifiImei,
      this.slotIndex,
      this.popResult});

  factory Popup.fromJson(Map<String, dynamic> json) => _$PopupFromJson(json);

  Map<String, dynamic> toJson() => _$PopupToJson(this);
}
