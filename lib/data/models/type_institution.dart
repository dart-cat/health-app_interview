import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/models/type_institution.g.dart';

@JsonSerializable()
class TypeInstitution {
  final int id;
  final String name;

  const TypeInstitution({
    required this.id,
    required this.name,
  });

  factory TypeInstitution.fromJson(Map<String, dynamic> json) => _$TypeInstitutionFromJson(json);
  Map<String, dynamic> toJson() => _$TypeInstitutionToJson(this);
}
