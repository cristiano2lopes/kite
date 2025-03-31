import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:kite/common/services/service_setup.dart';
import 'package:kite/common/services/storage.dart';
import 'package:kite/news/models/news_response.dart';
import 'package:kite/news/services/news.dart';
import 'package:kite/news_category/models/category.dart';
import 'package:kite/news_category/services/news_category.dart'
    show NewsCategoryService;

void bgWarmData(RootIsolateToken token){
  Isolate.run(() async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    final services = ServiceCoordinator();
    AppDataService dataService = services.getService<AppDataService>();
    final categoriesResponse = await dataService.fetchNewsCategories();
    final newsFutures = categoriesResponse.categories.map(
          (cat) => dataService.fetchNewsForCategory(cat.file),
    );
    await Future.wait(newsFutures);
  }, debugName: "warmData",);
}

class AppDataService {
  final StorageService storageService;
  final NewsCategoryService newsCategoryService;
  final NewsService newsService;

  AppDataService({
    required this.newsCategoryService,
    required this.newsService,
    required this.storageService,
  });

  Future<CategoriesResponse> fetchNewsCategories() async {
    return newsCategoryService.fetchNewsCategories();
  }

  Future<NewsResponse> fetchNewsForCategory(String category) async {
    return newsService.fetchNews(category);
  }

  void warmUpData() async {
    final token = RootIsolateToken.instance;
    if(token != null){
      bgWarmData(token);
    }
  }
}
