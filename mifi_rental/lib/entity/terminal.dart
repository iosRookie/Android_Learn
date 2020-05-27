import 'package:json_annotation/json_annotation.dart';

part "terminal.g.dart";

@JsonSerializable(nullable: false)

class Terminal {
  String mvnoCode;

  Terminal({this.mvnoCode});
  factory Terminal.fromJson(Map<String, dynamic> json) => _$TerminalFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalToJson(this);
}
