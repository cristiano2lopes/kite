import 'package:kite/common/models/bootstrap.dart';
import 'package:kite/common/services/app_data.dart';
import 'package:kite/common/services/navigation.dart';
import 'package:kite/news_category/models/category.dart';

class BootstrapService{

  final AppDataService appDataService;
  final NavigationService navigationService;

  BootstrapService({required this.appDataService, required this.navigationService});

  Future<BootstrapData> bootstrap() async {
    CategoriesResponse categories = await appDataService.fetchNewsCategories();
    String route = await getInitialRoute(categories);
    appDataService.warmUpData();
    return BootstrapData(initialRoute: route, categoriesResponse: categories);
  }

  Future<String> getInitialRoute(CategoriesResponse categoriesResponse) async{
    Category? cat = categoriesResponse.getTopPriorityCategory();
    if(cat != null){
      return navigationService.newsRoute(cat.file);
    }else{
      throw Exception("No categories available");
    }
  }

}