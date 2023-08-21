// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      email: json['email'] as String,
      gender: json['gender'] as String,
      types_users: json['types_users'] as String,
      city: json['city'] as String,
      email_verified_at: json['email_verified_at'] == null
          ? null
          : DateTime.parse(json['email_verified_at'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'gender': instance.gender,
      'types_users': instance.types_users,
      'city': instance.city,
      'email_verified_at': instance.email_verified_at?.toIso8601String(),
    };
