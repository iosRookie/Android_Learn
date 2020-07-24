// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal_site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalSite _$TerminalSiteFromJson(Map<String, dynamic> json) {
  return TerminalSite(
    json['id'] as int,
    json['updateTm'] as int,
    json['mvnoCode'] as String,
    json['bankCode'] as String,
    json['bankName'] as String,
    json['bankPhone'] as String,
    json['chargePerson'] as String,
    json['chargePhone'] as String,
    json['cabinetCount'] as String,
    json['countryCity'] as String,
    json['address'] as String,
    (json['bankLat'] as num)?.toDouble(),
    (json['bankLng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TerminalSiteToJson(TerminalSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updateTm': instance.updateTm,
      'mvnoCode': instance.mvnoCode,
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'bankPhone': instance.bankPhone,
      'chargePerson': instance.chargePerson,
      'chargePhone': instance.chargePhone,
      'cabinetCount': instance.cabinetCount,
      'countryCity': instance.countryCity,
      'address': instance.address,
      'bankLat': instance.bankLat,
      'bankLng': instance.bankLng,
    };
