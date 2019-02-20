import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  final String title;
  final String url;

  WebPage({this.title,this.url});

  @override
  Widget build(BuildContext context) {
    return new WebView(
      onWebViewCreated: (WebViewController webViewController) {
//          _webViewController = webViewController;
//          _webViewController.addListener(() {
//            int _scrollY = _webViewController.scrollY.toInt();
//            if (_scrollY < 480 && _isShowFloatBtn) {
//              _isShowFloatBtn = false;
//              setState(() {});
//            } else if (_scrollY > 480 && !_isShowFloatBtn) {
//              _isShowFloatBtn = true;
//              setState(() {});
//            }
//          });
      },
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
//    return Container(
//      child: new WebviewScaffold(
//        url: url,
//        appBar: new AppBar(
//          title:Text(title),
//        ),
//        withZoom: true,
//        withLocalStorage: true,
//        hidden: true,
//        initialChild: new Center(
//          child: new CircularProgressIndicator(),
//        ),
//      ),
//    );
  }

}