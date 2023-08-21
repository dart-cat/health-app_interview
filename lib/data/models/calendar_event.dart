import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/models/calendar_event.g.dart';

@JsonSerializable()
class CalendarEventItem {
  int? id;
  EventType title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  Frequency? frequency;
  List<DateTime> times;
  Duration? remindBefore;

  CalendarEventItem({
    this.id,
    required this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.frequency,
    required this.times,
    this.remindBefore,
  });

  factory CalendarEventItem.fromJson(Map<String, dynamic> json) => _$CalendarEventItemFromJson(json);
  Map<String, dynamic> toJson() => _$CalendarEventItemToJson(this);
}

enum EventType {
  appointment,
  testing,
  therapy,
  other,
}

enum Frequency {
  once,
  daily,
  everyFewDays,
  onceAWeek,
  onceAMonth,
}
