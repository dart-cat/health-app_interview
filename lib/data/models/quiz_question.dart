import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/quiz_question.g.dart';

@JsonSerializable()
class QuizQuestion {
  String question;
  bool? checked;

  QuizQuestion({required this.question, this.checked});

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuizQuestionToJson(this);
}
