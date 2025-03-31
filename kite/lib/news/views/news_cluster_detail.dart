import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kite/common/views/ui_constants.dart';
import 'package:kite/news/models/news_cluster.dart';

class NewsClusterDetailViewModel {
  final NewsCluster cluster;
  final String? categoryId;

  NewsClusterDetailViewModel({required this.cluster, this.categoryId});

  String getTitle() {
    return cluster.title;
  }
}

class NewsClusterDetail extends StatelessWidget {
  final NewsClusterDetailViewModel viewModel;

  const NewsClusterDetail(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Padding(
          padding: screenPadding,
          child:   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.pop(),
                child: Row(
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, size: appBarIconSize,),
                    Text("Back", style: Theme.of(context).textTheme.displayMedium,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: screenPadding,
          child: Column(children: [Text(viewModel.getTitle())]),
        ),
      ),
    );
  }
}
