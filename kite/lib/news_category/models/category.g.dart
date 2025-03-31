// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) =>
    Category(name: json['name'] as String, file: json['file'] as String);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'name': instance.name,
  'file': instance.file,
};

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      timestamp: const EpochDateTimeConverter().fromJson(
        (json['timestamp'] as num).toInt(),
      ),
      categories:
          (json['categories'] as List<dynamic>)
              .map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'timestamp': const EpochDateTimeConverter().toJson(instance.timestamp),
      'categories': instance.categories,
    };
