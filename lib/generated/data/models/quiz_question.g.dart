// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/quiz_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) => QuizQuestion(
      question: json['question'] as String,
      checked: json['checked'] as bool?,
    );

Map<String, dynamic> _$QuizQuestionToJson(QuizQuestion instance) =>
    <String, dynamic>{
      'question': instance.question,
      'checked': instance.checked,
    };
