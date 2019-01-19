import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';

class WebPage extends StatelessWidget {
  final String title;
  final String url;

  WebPage({this.title,this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new WebviewScaffold(
        url: url,
        appBar: new AppBar(
          title:Text(title),
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: new Center(
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}