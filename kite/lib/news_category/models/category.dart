import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kite/common/data_utils.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String name;
  final String file;

  bool get isForCountry => isCountry(name);

  Category({required this.name, required this.file});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class CategoriesResponse {

  @EpochDateTimeConverter()
  final DateTime timestamp;
  final List<Category> categories;

  CategoriesResponse({required this.timestamp, required this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);

  Category? getCategoryForId(String categoryId) {
    return categories.firstWhereOrNull((cat) => cat.file == categoryId);
  }

  Category? getTopPriorityCategory() {
    return categories.firstOrNull;
  }
}
