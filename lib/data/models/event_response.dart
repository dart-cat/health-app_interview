import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/models/event_response.g.dart';

@JsonSerializable()
class EventResponseItem {
  int id;
  // ignore: non_constant_identifier_names
  int user_id;
  // ignore: non_constant_identifier_names
  String event_type;
  // ignore: non_constant_identifier_names
  String? event_name;
  // ignore: non_constant_identifier_names
  String? what_remind;
  String? date;
  // ignore: non_constant_identifier_names
  String? time_receipt;
  // ignore: non_constant_identifier_names
  DateTime? date_start;
  String? periodicity;
  // ignore: non_constant_identifier_names
  DateTime? date_completion;
  String time;
  // ignore: non_constant_identifier_names
  String? time_remind;

  EventResponseItem({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore: non_constant_identifier_names
    required this.event_type,
    // ignore: non_constant_identifier_names
    this.event_name,
    // ignore: non_constant_identifier_names
    this.what_remind,
    this.date,
    // ignore: non_constant_identifier_names
    this.time_receipt,
    // ignore: non_constant_identifier_names
    this.date_start,
    this.periodicity,
    // ignore: non_constant_identifier_names
    this.date_completion,
    required this.time,
    // ignore: non_constant_identifier_names
    this.time_remind,
  });

  factory EventResponseItem.fromJson(Map<String, dynamic> json) => _$EventResponseItemFromJson(json);
  Map<String, dynamic> toJson() => _$EventResponseItemToJson(this);
}
