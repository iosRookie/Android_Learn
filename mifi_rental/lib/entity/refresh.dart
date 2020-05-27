import 'package:json_annotation/json_annotation.dart';

part "refresh.g.dart";

@JsonSerializable(nullable: false)
class Refresh {
  String date;

  Refresh({this.date});
  factory Refresh.fromJson(Map<String, dynamic> json) => _$RefreshFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshToJson(this);
}
