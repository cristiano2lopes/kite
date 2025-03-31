import 'package:go_router/go_router.dart';


class AppRoutes {
  static final String rootRoute = "/";
  static final String newsRoute = "/news/:categoryId";
  static final String newsDetailRoute = "/news/:categoryId/detail";
}

class NavigationService{

  GoRouter? _router;

  set router(GoRouter router){
    _router = router;
  }

  NavigationService({GoRouter? router}){
    _router = router;
  }

  void go(String route, {Object? extra}){
    _router?.go(route, extra: extra);
  }

  Future<void> push(String route, {Object? extra}) async{
    await _router?.push(route, extra: extra);
  }

  String newsRoute(String category) {
    return AppRoutes.newsRoute.replaceFirst(":categoryId", category);
  }

  String newsDetail(String category) {
    return AppRoutes.newsDetailRoute.replaceFirst(":categoryId", category);
  }

}