import 'package:json_annotation/json_annotation.dart';
part '../../generated/data/models/article.g.dart';

@JsonSerializable()
class Article {
  int id;
  String title;
  String text;

  Article({
    required this.id,
    required this.title,
    required this.text,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
