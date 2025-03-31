// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
  timestamp: const EpochDateTimeConverter().fromJson(
    (json['timestamp'] as num).toInt(),
  ),
  category: json['category'] as String?,
  read: (json['read'] as num?)?.toInt(),
  responseType: $enumDecode(_$ResponseTypeEnumMap, json['response_type']),
  clusters:
      (json['clusters'] as List<dynamic>?)
          ?.map((e) => NewsCluster.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  events:
      (json['events'] as List<dynamic>?)
          ?.map((e) => NewsEvent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{
      'timestamp': const EpochDateTimeConverter().toJson(instance.timestamp),
      'category': instance.category,
      'read': instance.read,
      'clusters': instance.clusters,
      'events': instance.events,
      'response_type': _$ResponseTypeEnumMap[instance.responseType]!,
    };

const _$ResponseTypeEnumMap = {
  ResponseType.clusters: 'clusters',
  ResponseType.events: 'events',
};
