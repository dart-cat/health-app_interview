import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/models/user.g.dart';

@JsonSerializable()
class User {
  int id;
  String email;
  String gender;
  // ignore: non_constant_identifier_names
  String types_users;
  String city;
  // ignore: non_constant_identifier_names
  DateTime? email_verified_at;

  User({
    required this.id,
    required this.email,
    required this.gender,
    // ignore: non_constant_identifier_names
    required this.types_users,
    required this.city,
    // ignore: non_constant_identifier_names
    this.email_verified_at,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
