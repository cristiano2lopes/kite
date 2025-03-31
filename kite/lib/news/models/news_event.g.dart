// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsEvent _$NewsEventFromJson(Map<String, dynamic> json) => NewsEvent(
  json['year'] as String,
  json['content'] as String,
  (json['sort_year'] as num).toDouble(),
  json['type'] as String,
);

Map<String, dynamic> _$NewsEventToJson(NewsEvent instance) => <String, dynamic>{
  'year': instance.year,
  'content': instance.content,
  'sort_year': instance.sortYear,
  'type': instance.type,
};
