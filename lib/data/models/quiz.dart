import 'package:json_annotation/json_annotation.dart';
import 'package:vstrecha/data/models/quiz_question.dart';

part '../../generated/data/models/quiz.g.dart';

@JsonSerializable()
class Quiz {
  String title;
  List<QuizQuestion> questions;

  Quiz({required this.title, required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
