import 'dart:convert';

import 'package:kite/common/models/api_router.dart';
import 'package:kite/common/services/data_fetcher.dart';
import 'package:kite/common/services/storage.dart';
import 'package:kite/news/models/news_response.dart';

class NewsService {

  final ApiRouter apiRouter = ApiRouter();
  final StorageService storageService;
  final Duration reFetchDurationForNewsCluster = Duration(hours: 24);

  NewsService({required this.storageService});

  bool isNewsResponseFresh(NewsResponse data){
    final currentTime = DateTime.now();
    return currentTime.difference(data.timestamp) < reFetchDurationForNewsCluster;
  }

  Future<void> persistNewsResponse(String category, NewsResponse data) async{
    await storageService.write(category, json.encode(data.toJson()));
  }

  Future<String> readNewsResponseFromStorage(String category) async{
    return await storageService.read(category);
  }

  MultiSourceDataFetcher<NewsResponse> fetcherForCategory(String category) {
    return MultiSourceDataFetcher<NewsResponse>([
      LocalDataFetcher<NewsResponse>(
          readData: () => readNewsResponseFromStorage(category),
          isDataStalled: (data) => !isNewsResponseFresh(data),
      ),
      HttpDataFetcher<NewsResponse>(
        apiRouter.uriForPath(category).toString(),
        persistData: persistNewsResponse,
      ),
    ]);
  }

  Future<NewsResponse> fetchNews(String category) async {
    final fetcher = fetcherForCategory(category);
    return fetcher.fetchData((data) => NewsResponse.fromJson(data));
  }
}
