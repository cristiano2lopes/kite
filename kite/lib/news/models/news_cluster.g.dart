// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_cluster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsCluster _$NewsClusterFromJson(Map<String, dynamic> json) => NewsCluster(
  (json['cluster_number'] as num).toInt(),
  json['category'] as String,
  json['title'] as String,
  json['short_summary'] as String,
  json['did_you_know'] as String,
  json['quote'] as String,
  json['quote_author'] as String,
  json['quote_source_url'] as String,
  json['location'] as String,
  (forceList(json, 'talking_points') as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  (json['perspectives'] as List<dynamic>?)
          ?.map((e) => NewsPerspective.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  json['geopolitical_context'] as String,
  json['historical_background'] as String,
  json['humanitarian_impact'] as String,
  json['economic_implications'] as String,
  (forceList(json, 'international_reactions') as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  (forceList(json, 'timeline') as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  (json['articles'] as List<dynamic>?)
          ?.map((e) => NewsArticle.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  (json['domains'] as List<dynamic>?)
          ?.map((e) => NewsDomain.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$NewsClusterToJson(NewsCluster instance) =>
    <String, dynamic>{
      'cluster_number': instance.clusterNumber,
      'category': instance.category,
      'title': instance.title,
      'short_summary': instance.shortSummary,
      'did_you_know': instance.didYouKnow,
      'quote': instance.quote,
      'quote_author': instance.quoteAuthor,
      'quote_source_url': instance.quoteSourceUrl,
      'location': instance.location,
      'geopolitical_context': instance.geopoliticalContext,
      'historical_background': instance.historicalBackground,
      'humanitarian_impact': instance.humanitarianImpact,
      'economic_implications': instance.economicImplications,
      'talking_points': instance.talkingPoints,
      'international_reactions': instance.internationalReactions,
      'timeline': instance.timeline,
      'perspectives': instance.perspectives,
      'articles': instance.articles,
      'domains': instance.domains,
    };
