import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';

class ArticleDetailPage extends StatelessWidget {
  final Data data;

  ArticleDetailPage({this.data});

  @override
  Widget build(BuildContext context) {

    return new WebviewScaffold(
        url: data.link,
        appBar: new AppBar(
          title:Text(data.title),
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: new Center(
          child: new CircularProgressIndicator(),
        ),
    );
  }

}