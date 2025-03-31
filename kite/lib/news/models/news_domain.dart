import 'package:json_annotation/json_annotation.dart';

part 'news_domain.g.dart';

@JsonSerializable()
class NewsDomain {

  final String name;
  final String favicon;

  NewsDomain(this.name, this.favicon);

  factory NewsDomain.fromJson(Map<String, dynamic> json) => _$NewsDomainFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDomainToJson(this);
}
