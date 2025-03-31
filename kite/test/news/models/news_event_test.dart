import 'dart:convert';
import 'package:kite/news/models/news_response.dart';

import 'package:test/test.dart';

import '../../test_utils.dart';

void main() {

  late String eventContents;

  setUp(() async {
    eventContents = await loadFileFixture('test/news/models/onthisday.json');
  });

  group('News Events models', () {

    test('correctly load from json response', () {
      final Map<String, dynamic> jsonData = jsonDecode(eventContents);
      final response = NewsResponse.fromJson(jsonData);
      assert(response.responseType == ResponseType.events);
      assert(response.read == null);
      assert(response.clusters.isEmpty);
      assert(response.events.length == 18);
      assert(response.timestamp.toIso8601String() ==  "2025-03-22T12:02:50.000");
    });

    test('correctly loads a news event on the list of events from the response', () {
      final Map<String, dynamic> jsonData = jsonDecode(eventContents);
      final response = NewsResponse.fromJson(jsonData);
      final sampleElement = response.events.first;
      assert(sampleElement.year == '2016');
      assert(sampleElement.sortYear == 2016.2);
      assert(sampleElement.content == r'<b><a href="https://en.wikipedia.org/wiki/Rob_Ford" data-wiki-id="Q169303" title="Rob Ford">Rob Ford</a></b> (Mayor of Toronto) died.');
      assert(sampleElement.type == 'people');

    });

  });

}