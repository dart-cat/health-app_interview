import 'dart:convert';

QuizQuestionsId quizQuestionsIdFromJson(String str) =>
    QuizQuestionsId.fromJson(json.decode(str));

String quizQuestionsIdToJson(QuizQuestionsId data) =>
    json.encode(data.toJson());

class QuizQuestionsId {
  String status;
  Data data;

  QuizQuestionsId({
    required this.status,
    required this.data,
  });

  factory QuizQuestionsId.fromJson(Map<String, dynamic> json) =>
      QuizQuestionsId(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  List<AllQuestion> allQuestions;

  Data({
    required this.allQuestions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        allQuestions: List<AllQuestion>.from(
            json["all_questions"].map((x) => AllQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_questions":
            List<dynamic>.from(allQuestions.map((x) => x.toJson())),
      };
}

class AllQuestion {
  int? id;
  String? question;
  List<Answer> answers;

  AllQuestion({
    required this.id,
    required this.question,
    required this.answers,
  });

  factory AllQuestion.fromJson(Map<String, dynamic> json) => AllQuestion(
        id: json["id"],
        question: json["question"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class Answer {
  int? id;
  String? text;
  bool? answer;

  Answer({
    required this.id,
    required this.text,
    required this.answer
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        text: json["text"],
        answer: json["answer"] ?? false 
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
}
