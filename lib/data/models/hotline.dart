import 'package:json_annotation/json_annotation.dart';
import 'package:vstrecha/data/models/type_help.dart';

part '../../generated/data/models/hotline.g.dart';

@JsonSerializable(explicitToJson: true)
class Hotline {
  int id;
  // ignore: non_constant_identifier_names
  TypeHelp type_help_id;
  String name;
  String? phone;
  String services;
  // ignore: non_constant_identifier_names
  String? add_info;

  Hotline({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.type_help_id,
    required this.name,
    required this.phone,
    required this.services,
    // ignore: non_constant_identifier_names
    required this.add_info,
  });

  factory Hotline.fromJson(Map<String, dynamic> json) => _$HotlineFromJson(json);
  Map<String, dynamic> toJson() => _$HotlineToJson(this);
}
