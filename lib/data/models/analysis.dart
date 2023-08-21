import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/analysis.g.dart';

@JsonSerializable()
class AnalysisItem {
  int? id;
  String path;
  DateTime date;

  AnalysisItem({
    this.id,
    required this.path,
    required this.date,
  });

  factory AnalysisItem.fromJson(Map<String, dynamic> json) =>
      _$AnalysisItemFromJson(json);
  Map<String, dynamic> toJson() => _$AnalysisItemToJson(this);
}
