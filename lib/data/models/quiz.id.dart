import 'dart:convert';

QuizId quizIdFromJson(String str) => QuizId.fromJson(json.decode(str));

String quizIdToJson(QuizId data) => json.encode(data.toJson());

class QuizId {
    String status;
    Data? data;

    QuizId({
        required this.status,
        required this.data,
    });

    factory QuizId.fromJson(Map<String, dynamic> json) => QuizId(
        status: json["status"],
        data: Data?.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? status;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.name,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
