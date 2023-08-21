// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisItem _$AnalysisItemFromJson(Map<String, dynamic> json) => AnalysisItem(
      id: json['id'] as int?,
      path: json['path'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$AnalysisItemToJson(AnalysisItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'date': instance.date.toIso8601String(),
    };
