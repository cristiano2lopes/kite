import 'package:json_annotation/json_annotation.dart';

part 'news_article.g.dart';

@JsonSerializable()
class NewsArticle {

  final String title;
  final String link;
  final String domain;
  final String image;
  final String imageCaption;
  final DateTime date;

  NewsArticle(this.title, this.link, this.domain, this.image, this.imageCaption, this.date);

  factory NewsArticle.fromJson(Map<String, dynamic> json) => _$NewsArticleFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleToJson(this);
}
