import 'package:json_annotation/json_annotation.dart';
import 'package:kite/common/data_utils.dart';
import 'package:kite/news/models/news_event.dart';
import 'news_cluster.dart';

part 'news_response.g.dart';

enum ResponseType {
  clusters,
  events,
}

@JsonSerializable()
class NewsResponse {

  @EpochDateTimeConverter()
  final DateTime timestamp;
  final String? category;
  final int? read;
  final List<NewsCluster> clusters;
  final List<NewsEvent> events;
  final ResponseType responseType;

  NewsResponse({required this.timestamp, required this.category, required this.read, required this.responseType, this.clusters =  const [], this.events = const [],});

  factory NewsResponse.fromJson(Map<String, dynamic> json){
    final responseTypeFieldKey = "response_type";
    if((json["events"] as List? ?? []).isNotEmpty){
      json[responseTypeFieldKey] = ResponseType.events.name;
    }
    else if(json.containsKey("clusters")){
      json[responseTypeFieldKey] = ResponseType.clusters.name;
    }else {
      throw UnimplementedError("Unknown news response structure: not events or clusters");
    }
    return _$NewsResponseFromJson(json); 
  }

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}