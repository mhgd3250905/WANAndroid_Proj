import 'package:douban_movies/WanAndroid/article_list_content.dart';
import 'package:flutter/material.dart';

enum ArticleType {
  HOME_ARTICLE,
  NORMAL_ARTICLE,
  PROJECT_ARTICLE,
}

class ArticlePage extends StatelessWidget {
  final String name;
  final int id;
  final ArticleType type;

  ArticlePage({this.name, this.id, this.type});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(name),
      ),
      body: ArticleListPage(
        type: type,
        id: id,
      ),
    );
  }
}
