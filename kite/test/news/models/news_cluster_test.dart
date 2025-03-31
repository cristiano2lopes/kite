import 'dart:convert';
import 'package:kite/news/models/news_response.dart';

import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {

  late String clustersContents;

  setUp(() async {
    clustersContents = await loadFileFixture('test/news/models/world.json');
  });

  group('News Cluster models', () {

    test('correctly load from json response', () {
      final Map<String, dynamic> jsonData = jsonDecode(clustersContents);
      final response = NewsResponse.fromJson(jsonData);
      assert(response.responseType == ResponseType.clusters);
      assert(response.read == 539);
      assert(response.events.isEmpty);
      assert(response.clusters.length == 12);
      assert(response.timestamp.toIso8601String() ==  "2025-03-22T12:15:59.000");
    });

    test('correctly loads a news cluster on the list of cluster from the response', () {
      final Map<String, dynamic> jsonData = jsonDecode(clustersContents);
      final response = NewsResponse.fromJson(jsonData);
      final clusters = response.clusters;
      assert(clusters.length == 12);
    });

  });

}