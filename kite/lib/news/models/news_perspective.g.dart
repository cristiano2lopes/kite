// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_perspective.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsPerspective _$NewsPerspectiveFromJson(Map<String, dynamic> json) =>
    NewsPerspective(
      json['text'] as String,
      (json['sources'] as List<dynamic>)
          .map((e) => NewsSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsPerspectiveToJson(NewsPerspective instance) =>
    <String, dynamic>{'text': instance.text, 'sources': instance.sources};
