import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(nullable: false)
class Order {
  String mvnoCode; //mvno编码
  String terminalSn; //机柜编码
  String orderSn; //订单编号
  String mifiImei; //设备imei码 扫码下单时此项为空
  String customerId; //用户id
  int rentTm; //租赁时间
  int returnTm; //归还时间
  String usedTmStr; //使用时长
  String currencyCode; //货币类型
  int deposit; //预授权金额 单位为分
  int shouldPay; //应付金额 单位为分
  int actuallyPay; //实付金额 单位为分
  String payStatus; //支付状态  UN_PAYED-未支付, PAYED-已支付
  String returnStatus; //归还状态  NOT_RETURN-未归还，RETURNED-已归还
  String saleStatus; //转售状态 UN_SALE-未转售，SALED-已转售
  String
      orderStatus; //订单状态  IN_ORDER-下单中，IN_USING-使用中，CANCELED-已取消，FINISHED-已完成
  int canPopup; //是否可以进行设备弹出操作  0 否，1 是
  int createTm; //订单创建时间
  int updateTm; //订单更新时间

  Order(
      {this.mvnoCode,
      this.terminalSn,
      this.orderSn,
      this.mifiImei,
      this.customerId,
      this.rentTm = 0,
      this.returnTm = 0,
      this.usedTmStr,
      this.currencyCode,
      this.deposit = 0,
      this.shouldPay = 0,
      this.actuallyPay = 0,
      this.payStatus,
      this.returnStatus,
      this.saleStatus,
      this.orderStatus,
      this.canPopup = 0,
      this.createTm,
      this.updateTm}); //订单更新时间

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

class PayStatus {
  static const String UN_PAYED = 'UN_PAYED';
  static const String PAYED = 'PAYED';
}

class OrderStatus {
  static const String IN_ORDER = 'IN_ORDER';
  static const String IN_USING = 'IN_USING';
  static const String CANCELED = 'CANCELED';
  static const String FINISHED = 'FINISHED';
}
