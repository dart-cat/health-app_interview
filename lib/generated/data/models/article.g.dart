// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
    };
