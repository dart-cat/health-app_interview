import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/country.g.dart';

@JsonSerializable()
class Country {
  int id;
  String name;

  Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
