import 'package:json_annotation/json_annotation.dart';
import 'package:vstrecha/data/models/city.dart';
import 'package:vstrecha/data/models/country.dart';
import 'package:vstrecha/data/models/type_institution.dart';

part '../../generated/data/models/institution.g.dart';

@JsonSerializable(explicitToJson: true)
class Institution {
  final String name;
  // ignore: non_constant_identifier_names
  final City? city_id;
  // ignore: non_constant_identifier_names
  final Country? country_id;
  final String? region;
  final String address;
  final String? coordinates;
  final String? email;
  final String? phone;
  // ignore: non_constant_identifier_names
  final String? link_website;
  final String? description;
  // ignore: non_constant_identifier_names
  final String? add_info;
  // ignore: non_constant_identifier_names
  final String? working_hours;
  // ignore: non_constant_identifier_names
  final TypeInstitution type_id;
  final String photo;
  final List<String>? keyGroups;

  const Institution({
    required this.name,
    // ignore: non_constant_identifier_names
    this.city_id,
    // ignore: non_constant_identifier_names
    this.country_id,
    this.region,
    required this.address,
    required this.coordinates,
    required this.email,
    required this.phone,
    // ignore: non_constant_identifier_names
    required this.link_website,
    required this.description,
    // ignore: non_constant_identifier_names
    this.add_info,
    // ignore: non_constant_identifier_names
    this.working_hours,
    // ignore: non_constant_identifier_names
    required this.type_id,
    required this.photo,
    this.keyGroups,
  });

  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);
  Map<String, dynamic> toJson() => _$InstitutionToJson(this);
}
