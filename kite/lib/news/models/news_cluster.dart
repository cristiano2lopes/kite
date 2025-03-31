import 'package:json_annotation/json_annotation.dart';
import 'package:kite/common/data_utils.dart';
import 'package:kite/news/models/news_article.dart';
import 'package:kite/news/models/news_domain.dart';
import 'package:kite/news/models/news_perspective.dart';

part 'news_cluster.g.dart';

@JsonSerializable()
class NewsCluster {

  final int clusterNumber;
  final String category;
  final String title;
  final String shortSummary;
  final String didYouKnow;
  final String quote;
  final String quoteAuthor;
  final String quoteSourceUrl;
  final String location;
  final String geopoliticalContext;
  final String historicalBackground;
  final String humanitarianImpact;
  final String economicImplications;
  @JsonKey(readValue: forceList)
  final List<String> talkingPoints;
  @JsonKey(readValue: forceList)
  final List<String> internationalReactions;
  @JsonKey(readValue: forceList)
  final List<String> timeline;
  @JsonKey(defaultValue: [])
  final List<NewsPerspective> perspectives;
  @JsonKey(defaultValue: [])
  final List<NewsArticle> articles;
  @JsonKey(defaultValue: [])
  final List<NewsDomain> domains;

  NewsCluster(this.clusterNumber, this.category, this.title, this.shortSummary, this.didYouKnow, this.quote, this.quoteAuthor, this.quoteSourceUrl, this.location, this.talkingPoints, this.perspectives, this.geopoliticalContext, this.historicalBackground, this.humanitarianImpact, this.economicImplications, this.internationalReactions, this.timeline, this.articles, this.domains);

  factory NewsCluster.fromJson(Map<String, dynamic> json) => _$NewsClusterFromJson(json);

  Map<String, dynamic> toJson() => _$NewsClusterToJson(this);

}
