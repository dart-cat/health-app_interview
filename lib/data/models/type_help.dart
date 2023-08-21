import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/models/type_help.g.dart';

@JsonSerializable()
class TypeHelp {
  int id;
  String name;

  TypeHelp({required this.id, required this.name});

  factory TypeHelp.fromJson(Map<String, dynamic> json) => _$TypeHelpFromJson(json);
  Map<String, dynamic> toJson() => _$TypeHelpToJson(this);
}
