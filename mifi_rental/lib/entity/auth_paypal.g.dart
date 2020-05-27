// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_paypal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthPaypal _$AuthPaypalFromJson(Map<String, dynamic> json) {
  return AuthPaypal(
    loginCustomerId: json['loginCustomerId'] as String,
    orderSn: json['orderSn'] as String,
    streamNo: json['streamNo'] as String,
    totalAmount: json['totalAmount'] as String,
    orderSubject: json['orderSubject'] as String,
    orderDesc: json['orderDesc'] as String,
    currencyCode: json['currencyCode'] as String,
    busiCustom: json['busiCustom'] as String,
    clientDesc: json['clientDesc'] as String,
    localeCode: json['localeCode'] as String,
    projectName: json['projectName'] as String,
    langType: json['langType'] as String,
    mvnoCode: json['mvnoCode'] as String,
  );
}

Map<String, dynamic> _$AuthPaypalToJson(AuthPaypal instance) =>
    <String, dynamic>{
      'loginCustomerId': instance.loginCustomerId,
      'orderSn': instance.orderSn,
      'streamNo': instance.streamNo,
      'totalAmount': instance.totalAmount,
      'orderSubject': instance.orderSubject,
      'orderDesc': instance.orderDesc,
      'currencyCode': instance.currencyCode,
      'busiCustom': instance.busiCustom,
      'clientDesc': instance.clientDesc,
      'localeCode': instance.localeCode,
      'projectName': instance.projectName,
      'langType': instance.langType,
      'mvnoCode': instance.mvnoCode,
    };
