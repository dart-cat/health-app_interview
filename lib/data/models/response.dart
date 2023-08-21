import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class APIResponse<T> {
  String status;
  T data;

  APIResponse({required this.status, required this.data});

  factory APIResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJson) =>
      _$APIResponseFromJson(json, fromJson);
  Map<String, dynamic> toJson(Object? Function(T) toJson) =>
      _$APIResponseToJson(this, toJson);
}
