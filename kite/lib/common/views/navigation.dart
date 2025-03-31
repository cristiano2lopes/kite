import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kite/common/services/app_data.dart';
import 'package:kite/common/services/bootstrap.dart';
import 'package:kite/common/services/navigation.dart';
import 'package:kite/common/services/service_setup.dart';
import 'package:kite/common/views/app.dart';
import 'package:kite/news/models/news_cluster.dart';
import 'package:kite/news/services/news.dart';
import 'package:kite/news/views/news_cluster_detail.dart';
import 'package:kite/news/views/news_clusters.dart';
import 'package:kite/news_category/models/category.dart';

GoRouter makeRouter(ServiceCoordinator serviceCoordinator) {
  final GoRouter router = GoRouter(
    initialLocation: AppRoutes.rootRoute,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.rootRoute,
        builder: (BuildContext context, GoRouterState state) {
          final navS = serviceCoordinator.getService<NavigationService>();
          final appDataS = serviceCoordinator.getService<AppDataService>();
          final bootstrapS = BootstrapService(appDataService: appDataS, navigationService: navS);
          final viewModel = AppEntryPointViewModel(
            bootstrapService: bootstrapS,
            navigationService: navS,
          );
          return AppEntryPoint(viewModel);
        },
      ),
      GoRoute(
        path: AppRoutes.newsDetailRoute,
        builder: (BuildContext context, GoRouterState state) {
          final categoryId = state.pathParameters['categoryId'];
          final cluster = state.extra as NewsCluster?;
          if(cluster == null){
            throw UnimplementedError("Cluster argument is required");
          }
          NewsClusterDetailViewModel viewModel = NewsClusterDetailViewModel(cluster: cluster, categoryId: categoryId);
          return NewsClusterDetail(viewModel);
        },
      ),
      GoRoute(
        path: AppRoutes.newsRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final categoryId = state.pathParameters['categoryId'];
          if(categoryId == null){
            throw UnimplementedError("Path argument is required");
          }

          final categoriesResponse = state.extra as CategoriesResponse?;
          if(categoriesResponse == null){
            throw UnimplementedError("Categories argument is required");
          }

          final newsS = serviceCoordinator.getService<NewsService>();
          final navS = serviceCoordinator.getService<NavigationService>();
          final viewModel = NewsClustersViewModel(
            categoriesResponse: categoriesResponse,
            newsService: newsS,
            categoryId: categoryId,
            navigationService: navS,
          );
          return NoTransitionPage(child: NewsClusters(viewModel));
        },
      ),
    ],
  );
  return router;
}
