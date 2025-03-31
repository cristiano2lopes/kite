import 'package:get_it/get_it.dart';
import 'package:kite/common/services/app_data.dart';
import 'package:kite/common/services/navigation.dart';
import 'package:kite/common/services/storage.dart';
import 'package:kite/news/services/news.dart';
import 'package:kite/news_category/services/news_category.dart';


class ServiceCoordinator{

  final _services = GetIt.instance;

  ServiceCoordinator(){
    _services.registerSingleton<NavigationService>(NavigationService(),);

    final storageService = StorageService();
    _services.registerSingleton<StorageService>(storageService,);

    final newsCategoryService = NewsCategoryService(storageService: storageService);
    _services.registerSingleton<NewsCategoryService>(newsCategoryService);

    final newsService = NewsService(storageService: storageService);
    _services.registerSingleton<NewsService>(newsService);

    final appDataService = AppDataService(
      storageService: storageService,
      newsCategoryService: newsCategoryService,
      newsService: newsService,
    );
    _services.registerSingleton<AppDataService>(appDataService);
  }

  T getService<T extends Object>(){
    return _services.get<T>();
  }

}