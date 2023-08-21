import 'package:json_annotation/json_annotation.dart';
import 'package:vstrecha/data/models/user.dart';

part '../../generated/data/models/login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String text;
  User user;

  LoginResponse({
    required this.text,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
