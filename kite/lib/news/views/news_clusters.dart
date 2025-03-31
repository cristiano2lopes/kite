import 'package:flutter/material.dart';
import 'package:kite/common/data_utils.dart';
import 'package:kite/common/services/navigation.dart';
import 'package:kite/common/views/splash_screen.dart';
import 'package:kite/common/views/ui_constants.dart';
import 'package:kite/news/models/news_cluster.dart';
import 'package:kite/news/models/news_response.dart';
import 'package:kite/news/services/news.dart';
import 'package:kite/news/views/category_picker.dart';
import 'package:kite/news/views/events.dart';
import 'package:kite/news_category/models/category.dart';

import 'news_list.dart';

class NewsClustersViewModel {
  final String categoryId;
  final NewsService newsService;
  final CategoriesResponse categoriesResponse;
  final NavigationService navigationService;

  NewsClustersViewModel({
    required this.categoryId,
    required this.categoriesResponse,
    required this.newsService,
    required this.navigationService,
  });

  Category? getSelectedCategory() {
    return categoriesResponse.getCategoryForId(categoryId);
  }

  List<Category> getCategories() {
    return categoriesResponse.categories;
  }

  void goToCategory(Category category) {
    navigationService.go(
      navigationService.newsRoute(category.file),
      extra: categoriesResponse,
    );
  }

  void goToNewsDetail(NewsCluster news) async {
    Category? category = getSelectedCategory();
    if (category == null) {
      throw Exception("Navigating without selected category");
    }
    await navigationService.push(
      navigationService.newsDetail(category.file),
      extra: news,
    );
  }

  void refreshData() {
    // TODO
  }

  Future<NewsResponse?> fetchNews(Category? category) async {
    if (category == null) {
      return null;
    }
    return newsService.fetchNews(category.file);
  }

  String getDate() {
    return formatDate(categoriesResponse.timestamp);
  }
}

class NewsClusters extends StatelessWidget {
  final NewsClustersViewModel viewModel;

  const NewsClusters(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: screenPadding,
          child: CategoryPicker(
            CategoryPickerViewModel(
              selectedCategory: viewModel.getSelectedCategory(),
              categories: viewModel.getCategories(),
              goToCategory: (Category category) {
                viewModel.goToCategory(category);
              },
              refreshAction: () {
                viewModel.refreshData();
              },
            ),
          ),
        ),
        leadingWidth: 300,
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                viewModel.getDate(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        // title: Text("2025-01-01"),
      ),
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Padding(
          padding: screenPadding,
          child: FutureBuilder<NewsResponse?>(
            future: viewModel.fetchNews(viewModel.getSelectedCategory()),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                case ConnectionState.active:
                  return const SplashScreen();
                case ConnectionState.done:
                  final newsData = snapshot.data;
                  return switch (newsData?.responseType) {
                    ResponseType.events => Events(
                      EventsViewModel(newsResponse: newsData),
                    ),
                    ResponseType.clusters || null => NewsList(
                      NewsListViewModel(
                        newsResponse: newsData,
                        goToNewsDetail: viewModel.goToNewsDetail,
                      ),
                    ),
                  };
              }
            },
          ),
        ),
      ),
    );
  }
}
