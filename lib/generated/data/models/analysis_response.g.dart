// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/analysis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisResponseItem _$AnalysisResponseItemFromJson(
        Map<String, dynamic> json) =>
    AnalysisResponseItem(
      id: json['id'] as int,
      date: json['date'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$AnalysisResponseItemToJson(
        AnalysisResponseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'name': instance.name,
      'link': instance.link,
    };
