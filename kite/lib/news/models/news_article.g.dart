// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticle _$NewsArticleFromJson(Map<String, dynamic> json) => NewsArticle(
  json['title'] as String,
  json['link'] as String,
  json['domain'] as String,
  json['image'] as String,
  json['image_caption'] as String,
  DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$NewsArticleToJson(NewsArticle instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'domain': instance.domain,
      'image': instance.image,
      'image_caption': instance.imageCaption,
      'date': instance.date.toIso8601String(),
    };
