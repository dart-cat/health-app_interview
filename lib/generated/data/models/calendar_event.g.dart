// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventItem _$CalendarEventItemFromJson(Map<String, dynamic> json) =>
    CalendarEventItem(
      id: json['id'] as int?,
      title: $enumDecode(_$EventTypeEnumMap, json['title']),
      description: json['description'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      frequency: $enumDecodeNullable(_$FrequencyEnumMap, json['frequency']),
      times: (json['times'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      remindBefore: json['remindBefore'] == null
          ? null
          : Duration(microseconds: json['remindBefore'] as int),
    );

Map<String, dynamic> _$CalendarEventItemToJson(CalendarEventItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': _$EventTypeEnumMap[instance.title]!,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'frequency': _$FrequencyEnumMap[instance.frequency],
      'times': instance.times.map((e) => e.toIso8601String()).toList(),
      'remindBefore': instance.remindBefore?.inMicroseconds,
    };

const _$EventTypeEnumMap = {
  EventType.appointment: 'appointment',
  EventType.testing: 'testing',
  EventType.therapy: 'therapy',
  EventType.other: 'other',
};

const _$FrequencyEnumMap = {
  Frequency.once: 'once',
  Frequency.daily: 'daily',
  Frequency.everyFewDays: 'everyFewDays',
  Frequency.onceAWeek: 'onceAWeek',
  Frequency.onceAMonth: 'onceAMonth',
};
