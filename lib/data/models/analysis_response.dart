import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/analysis_response.g.dart';

@JsonSerializable()
class AnalysisResponseItem {
  int id;
  String date;
  String name;
  String link;

  AnalysisResponseItem({
    required this.id,
    required this.date,
    required this.name,
    required this.link,
  });

  factory AnalysisResponseItem.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResponseItemFromJson(json);
  Map<String, dynamic> toJson() => _$AnalysisResponseItemToJson(this);
}
