import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable(nullable: false)
class Device {
  String mvnoCode;
  String mifiSn;
  String mifiImei;
  String terminalSn;
  String slotIndex;
  String softVersion;
  String wifiName;
  String wifiPwd;
  String battery;
  String mifiStatus;
  String wifiStatus;
  String netStatus;
  num createTm;
  num updateTm;

  Device(
      {this.mvnoCode,
      this.mifiSn,
      this.mifiImei,
      this.terminalSn,
      this.slotIndex,
      this.softVersion,
      this.wifiName,
      this.wifiPwd,
      this.battery,
      this.mifiStatus,
      this.wifiStatus,
      this.netStatus,
      this.createTm,
      this.updateTm});

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
