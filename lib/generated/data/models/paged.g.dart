// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/paged.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paged<T> _$PagedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Paged<T>(
      current_page: json['current_page'] as int,
      total_pages: json['total_pages'] as int,
      items: fromJsonT(json['items']),
    );

Map<String, dynamic> _$PagedToJson<T>(
  Paged<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'current_page': instance.current_page,
      'total_pages': instance.total_pages,
      'items': toJsonT(instance.items),
    };
