import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kite/news/models/news_event.dart';
import 'package:kite/news/models/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsViewModel {
  final NewsResponse? newsResponse;

  EventsViewModel({
    this.newsResponse,
  });

  List<NewsEvent> getEventsList() {
    return newsResponse?.events ?? [];
  }

  int getEventsLen() {
    return newsResponse?.events.length ?? 0;
  }


  FutureOr<bool> openUrl(String url) async{
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication,);
    return true;
  }
}

class Events extends StatelessWidget {
  final EventsViewModel viewModel;

  const Events(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        spacing: 20,
        children: [
          Center(
            child: Text('On this day'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.getEventsLen(),
              itemBuilder: (context, index) {
                final item = viewModel.getEventsList()[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: HtmlWidget(item.content, onTapUrl: viewModel.openUrl,),
                );
            },
                  ),
          ),
        ],
      ),
    );
  }
}