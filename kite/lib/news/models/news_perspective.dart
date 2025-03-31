import 'package:json_annotation/json_annotation.dart';
import 'package:kite/news/models/news_source.dart';

part 'news_perspective.g.dart';

@JsonSerializable()
class NewsPerspective {

  final String text;
  final List<NewsSource> sources;

  NewsPerspective(this.text, this.sources);

  factory NewsPerspective.fromJson(Map<String, dynamic> json) => _$NewsPerspectiveFromJson(json);

  Map<String, dynamic> toJson() => _$NewsPerspectiveToJson(this);
}
