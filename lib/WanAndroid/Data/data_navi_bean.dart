import 'dart:convert' show json;

import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';

class NaviBean {
  int errorCode;
  String errorMsg;
  List<NaviNode> nodes;

  NaviBean.fromParams({
    this.errorCode,
    this.errorMsg,
    this.nodes,
  });

  factory NaviBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new NaviBean.fromJson(json.decode(jsonStr))
          : new NaviBean.fromJson(jsonStr);

  NaviBean.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    nodes = jsonRes['data'] == null ? null : [];

    for (var node in nodes == null ? [] : jsonRes['data']) {
      nodes.add(node == null ? null : new NaviNode.fromJson(node));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class NaviNode {
  int cid;
  String name;
  List<Data> articles;

  NaviNode.fromParams({this.cid, this.name, this.articles});

  factory NaviNode(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new NaviNode.fromJson(json.decode(jsonStr))
          : new NaviNode.fromJson(jsonStr);

  NaviNode.fromJson(jsonRes) {
    cid = jsonRes['cid'];
    name = jsonRes['name'];
    articles = jsonRes['articles'] == null ? null : [];

    for (var article in articles == null ? [] : jsonRes['articles']) {
      articles.add(article == null ? null : new Data.fromJson(article));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
