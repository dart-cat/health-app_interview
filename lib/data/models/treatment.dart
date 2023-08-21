import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/models/treatment.g.dart';

@JsonSerializable()
class TreatmentItem {
  int? id;
  String title;
  DateTime? startDate;
  DateTime? endDate;
  Frequency? frequency;
  List<DateTime> times;
  Duration? remindBefore;

  TreatmentItem({
    this.id,
    required this.title,
    this.startDate,
    this.endDate,
    this.frequency,
    required this.times,
    this.remindBefore,
  });

  factory TreatmentItem.fromJson(Map<String, dynamic> json) => _$TreatmentItemFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentItemToJson(this);
}

enum Frequency {
  once,
  daily,
  everyFewDays,
  onceAWeek,
  onceAMonth,
}
