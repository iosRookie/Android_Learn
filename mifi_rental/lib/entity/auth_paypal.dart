import 'package:json_annotation/json_annotation.dart';

part 'auth_paypal.g.dart';

@JsonSerializable(nullable: false)
class AuthPaypal {
  final String loginCustomerId;
  final String orderSn;
  final String streamNo;
  final String totalAmount;
  final String orderSubject;
  final String orderDesc;
  final String currencyCode;
  final String busiCustom;
  final String clientDesc;
  final String localeCode;
  final String projectName;
  final String langType;
  final String mvnoCode;

  AuthPaypal(
      {this.loginCustomerId,
      this.orderSn,
      this.streamNo,
      this.totalAmount = '150',
      this.orderSubject = 'orderSubject',
      this.orderDesc = 'orderDesc',
      this.currencyCode,
      this.busiCustom = '123',
      this.clientDesc = '1.0',
      this.localeCode,
      this.projectName,
      this.langType,
      this.mvnoCode});

  factory AuthPaypal.fromJson(Map<String, dynamic> json) =>
      _$AuthPaypalFromJson(json);

  Map<String, dynamic> toJson() => _$AuthPaypalToJson(this);

  @override
  String toString() {
    return 'AuthPaypal{loginCustomerId: $loginCustomerId, orderSn: $orderSn, streamNo: $streamNo, totalAmount: $totalAmount, orderSubject: $orderSubject, orderDesc: $orderDesc, currencyCode: $currencyCode, busiCustom: $busiCustom, clientDesc: $clientDesc, localeCode: $localeCode, projectName: $projectName, langType: $langType, mvnoCode: $mvnoCode}';
  }
}
