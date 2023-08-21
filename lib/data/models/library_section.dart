import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/library_section.g.dart';

@JsonSerializable(explicitToJson: true)
class LibrarySection {
  int id;
  String name;
  List<LibrarySection> childrens;

  LibrarySection({
    required this.id,
    required this.name,
    required this.childrens,
  });

  factory LibrarySection.fromJson(Map<String, dynamic> json) => _$LibrarySectionFromJson(json);
  Map<String, dynamic> toJson() => _$LibrarySectionToJson(this);
}
