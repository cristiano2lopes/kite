import 'dart:convert';

import 'package:kite/common/models/api_router.dart';
import 'package:kite/common/services/data_fetcher.dart';
import 'package:kite/common/services/storage.dart';
import 'package:kite/news_category/models/category.dart';

class NewsCategoryService {
  late DataFetcher<CategoriesResponse> dataFetcher;
  final ApiRouter apiRouter = ApiRouter();
  final StorageService storageService;
  final Duration reFetchDurationForCategories = Duration(days: 5);

  NewsCategoryService({required this.storageService}) {
    dataFetcher = MultiSourceDataFetcher<CategoriesResponse>([
      LocalDataFetcher<CategoriesResponse>(
        readData: readNewsCategoriesFromStorage,
        isDataStalled: (data) => !isCategoriesResponseFresh(data),
      ),
      HttpDataFetcher<CategoriesResponse>(
        apiRouter.uriForCategories().toString(),
        persistData: persistCategoriesResponse,
      ),
    ]);
  }

  bool isCategoriesResponseFresh(CategoriesResponse data) {
    final currentTime = DateTime.now();
    return currentTime.difference(data.timestamp) <
        reFetchDurationForCategories;
  }

  Future<void> persistCategoriesResponse(
    String path,
    CategoriesResponse data,
  ) async {
    await storageService.write(path, json.encode(data.toJson()));
  }

  Future<String> readNewsCategoriesFromStorage() async{
    return await storageService.read(apiRouter.categories);
  }


  Future<CategoriesResponse> fetchNewsCategories() async {
    // TODO - Add some smarts here, should only more relevant countries
    // via set locale or ip location, geo (may need permissions) (to much needs permissions)
    final categoriesResponse = dataFetcher.fetchData((data) => CategoriesResponse.fromJson(data));
    return categoriesResponse;
  }

}
