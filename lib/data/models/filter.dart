import 'package:json_annotation/json_annotation.dart';
import 'package:vstrecha/data/models/city.dart';
import 'package:vstrecha/data/models/type_institution.dart';

part '../../generated/data/models/filter.g.dart';

@JsonSerializable(explicitToJson: true)
class Filter {
  final City? city;
  final TypeInstitution? type;

  const Filter({
    this.city,
    this.type,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
  Map<String, dynamic> toJson() => _$FilterToJson(this);
}
