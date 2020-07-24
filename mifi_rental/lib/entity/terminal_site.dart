import 'package:json_annotation/json_annotation.dart';

part 'terminal_site.g.dart';


@JsonSerializable()
class TerminalSite extends Object {

  int id;

  int updateTm;

  String mvnoCode;

  String bankCode;

  String bankName;

  String bankPhone;

  String chargePerson;

  String chargePhone;

  String cabinetCount;

  String countryCity;

  String address;

  double bankLat;

  double bankLng;

  TerminalSite(this.id,this.updateTm,this.mvnoCode,this.bankCode,this.bankName,this.bankPhone,this.chargePerson,this.chargePhone,this.cabinetCount,this.countryCity,this.address,this.bankLat,this.bankLng,);

  factory TerminalSite.fromJson(Map<String, dynamic> srcJson) => _$TerminalSiteFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TerminalSiteToJson(this);

}


