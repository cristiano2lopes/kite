import 'dart:convert';
import 'package:kite/news_category/models/category.dart';

import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {

  late String categoryContents;

  setUp(() async {
    categoryContents = await loadFileFixture('test/news_category/models/kite.json');
  });

  group('Category models', () {

    test('correctly load from json response', () {
      final Map<String, dynamic> jsonData = jsonDecode(categoryContents);
      final response = CategoriesResponse.fromJson(jsonData);
      assert(response.timestamp.toIso8601String() == "2025-03-21T17:09:11.000");
      assert(response.categories.length == 36);
    });

    test('correctly loads a category on the list of categories from the response', () {
      final Map<String, dynamic> jsonData = jsonDecode(categoryContents);
      final response = CategoriesResponse.fromJson(jsonData);
      final category = response.categories.firstWhere(
              (cat) => cat.name == "World",
      );
      assert(category.file == "world.json");
    });

  });

}