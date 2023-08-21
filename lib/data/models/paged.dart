import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/paged.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Paged<T> {
  // ignore: non_constant_identifier_names
  int current_page;
  // ignore: non_constant_identifier_names
  int total_pages;
  T items;

  Paged({
    // ignore: non_constant_identifier_names
    required this.current_page,
    // ignore: non_constant_identifier_names
    required this.total_pages,
    required this.items,
  });

  factory Paged.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJson) =>
      _$PagedFromJson(json, fromJson);
  Map<String, dynamic> toJson(Object? Function(T) toJson) =>
      _$PagedToJson(this, toJson);
}
