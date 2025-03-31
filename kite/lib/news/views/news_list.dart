import 'package:flutter/material.dart';
import 'package:kite/news/models/news_cluster.dart';
import 'package:kite/news/models/news_response.dart';

class NewsListViewModel {
  final NewsResponse? newsResponse;
  final Function(NewsCluster news) goToNewsDetail;

  NewsListViewModel({
    this.newsResponse,
    required this.goToNewsDetail,
  });

  String getCategoryName() {
    return newsResponse?.category ?? "Unknown Category";
  }

  List<NewsCluster> getNewsList() {
    return newsResponse?.clusters ?? [];
  }

  String getUnavailableText() {
    return "No news available for ${getCategoryName()}";
  }

  bool hasNews() {
    return newsResponse != null && getNewsList().isNotEmpty;
  }

  int getNewsLen() {
    return getNewsList().length;
  }
}

class NewsList extends StatelessWidget {
  final NewsListViewModel viewModel;

  const NewsList(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    if(!viewModel.hasNews()){
      return Center(child: Text(viewModel.getUnavailableText()),);
    }

    return ListView.builder(
      itemCount: viewModel.getNewsLen(),
      itemBuilder: (context, index) {
        final item = viewModel.getNewsList()[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(item.title),
          onTap: () async{
            await viewModel.goToNewsDetail(item);
          },
        );
      },
    );

  }

}
