import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/city.g.dart';

@JsonSerializable()
class City {
  int id;
  String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
