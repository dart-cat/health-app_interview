// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      type: json['type'] == null
          ? null
          : TypeInstitution.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'city': instance.city?.toJson(),
      'type': instance.type?.toJson(),
    };
