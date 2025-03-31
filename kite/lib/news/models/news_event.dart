import 'package:json_annotation/json_annotation.dart';

part 'news_event.g.dart';

@JsonSerializable()
class NewsEvent {

  final String year;
  final String content;
  final double sortYear;
  final String type;

  NewsEvent(this.year, this.content, this.sortYear, this.type);

  factory NewsEvent.fromJson(Map<String, dynamic> json) => _$NewsEventFromJson(json);

  Map<String, dynamic> toJson() => _$NewsEventToJson(this);
}
