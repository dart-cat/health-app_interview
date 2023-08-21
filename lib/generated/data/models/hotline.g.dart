// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/hotline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotline _$HotlineFromJson(Map<String, dynamic> json) => Hotline(
      id: json['id'] as int,
      type_help_id:
          TypeHelp.fromJson(json['type_help_id'] as Map<String, dynamic>),
      name: json['name'] as String,
      phone: json['phone'] as String?,
      services: json['services'] as String,
      add_info: json['add_info'] as String?,
    );

Map<String, dynamic> _$HotlineToJson(Hotline instance) => <String, dynamic>{
      'id': instance.id,
      'type_help_id': instance.type_help_id.toJson(),
      'name': instance.name,
      'phone': instance.phone,
      'services': instance.services,
      'add_info': instance.add_info,
    };
