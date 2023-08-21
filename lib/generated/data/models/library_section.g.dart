// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/library_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibrarySection _$LibrarySectionFromJson(Map<String, dynamic> json) =>
    LibrarySection(
      id: json['id'] as int,
      name: json['name'] as String,
      childrens: (json['childrens'] as List<dynamic>)
          .map((e) => LibrarySection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LibrarySectionToJson(LibrarySection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'childrens': instance.childrens.map((e) => e.toJson()).toList(),
    };
