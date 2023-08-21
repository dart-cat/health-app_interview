// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponseItem _$EventResponseItemFromJson(Map<String, dynamic> json) =>
    EventResponseItem(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      event_type: json['event_type'] as String,
      event_name: json['event_name'] as String?,
      what_remind: json['what_remind'] as String?,
      date: json['date'] as String?,
      time_receipt: json['time_receipt'] as String?,
      date_start: json['date_start'] == null
          ? null
          : DateTime.parse(json['date_start'] as String),
      periodicity: json['periodicity'] as String?,
      date_completion: json['date_completion'] == null
          ? null
          : DateTime.parse(json['date_completion'] as String),
      time: json['time'] as String,
      time_remind: json['time_remind'] as String?,
    );

Map<String, dynamic> _$EventResponseItemToJson(EventResponseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'event_type': instance.event_type,
      'event_name': instance.event_name,
      'what_remind': instance.what_remind,
      'date': instance.date,
      'time_receipt': instance.time_receipt,
      'date_start': instance.date_start?.toIso8601String(),
      'periodicity': instance.periodicity,
      'date_completion': instance.date_completion?.toIso8601String(),
      'time': instance.time,
      'time_remind': instance.time_remind,
    };
