// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Institution _$InstitutionFromJson(Map<String, dynamic> json) => Institution(
      name: json['name'] as String,
      city_id: json['city_id'] == null
          ? null
          : City.fromJson(json['city_id'] as Map<String, dynamic>),
      country_id: json['country_id'] == null
          ? null
          : Country.fromJson(json['country_id'] as Map<String, dynamic>),
      region: json['region'] as String?,
      address: json['address'] as String,
      coordinates: json['coordinates'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      link_website: json['link_website'] as String?,
      description: json['description'] as String?,
      add_info: json['add_info'] as String?,
      working_hours: json['working_hours'] as String?,
      type_id:
          TypeInstitution.fromJson(json['type_id'] as Map<String, dynamic>),
      photo: json['photo'] as String,
      keyGroups: (json['keyGroups'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$InstitutionToJson(Institution instance) =>
    <String, dynamic>{
      'name': instance.name,
      'city_id': instance.city_id?.toJson(),
      'country_id': instance.country_id?.toJson(),
      'region': instance.region,
      'address': instance.address,
      'coordinates': instance.coordinates,
      'email': instance.email,
      'phone': instance.phone,
      'link_website': instance.link_website,
      'description': instance.description,
      'add_info': instance.add_info,
      'working_hours': instance.working_hours,
      'type_id': instance.type_id.toJson(),
      'photo': instance.photo,
      'keyGroups': instance.keyGroups,
    };
