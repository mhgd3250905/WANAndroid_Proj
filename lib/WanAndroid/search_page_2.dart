import 'dart:io';

import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';
import 'package:douban_movies/WanAndroid/Data/data_key_bean.dart';
import 'package:douban_movies/WanAndroid/article_list_content.dart';
import 'package:flutter/material.dart';

import 'article_page.dart';

final String URL_HOT_KEY = 'http://www.wanandroid.com/hotkey/json';
final String URL_SEARCH = 'http://www.wanandroid.com/article/query/0/json';

List<KeyNode> nodes = [];

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('SearchBar'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: searchBarDelegate());
            },)
        ],
      ),
    );
  }

}


class searchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchFutureBuilder(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //如果说已经加载过一次搜索热榜，那么下次就不再重复加载了
    if (nodes.length == 0) {
      return buildDefaultFutureBuilder();
    } else {
      return new SearchDefaultView(
        nodes: nodes,
        callback: (key) {
          query = key;
          showResults(context);
        },
      );
    }
  }

  FutureBuilder<KeyBean> buildDefaultFutureBuilder() {
    return new FutureBuilder<KeyBean>(
      builder: (context, AsyncSnapshot<KeyBean> async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new Text('Waitiing...'),
          );
        }

        if (async.connectionState == ConnectionState.done) {
          debugPrint('done');
          if (async.hasError) {
            return new Center(
              child: new Text('Error:code '),
            );
          } else if (async.hasData) {
            KeyBean bean = async.data;
            nodes = bean.nodes;
            return new SearchDefaultView(
              nodes: nodes,
              callback: (key) {
                query = key;
                showResults(context);
              },
            );
          }
        }
      },
      future: getData(),
    );
  }

  Future<KeyBean> getData() async {
    debugPrint('getKeyBeanData');
    var dio = new Dio();
    Response response = await dio.get(URL_HOT_KEY);
    KeyBean bean = KeyBean.fromJson(response.data);
    return bean;
  }

  FutureBuilder<HomeBean> buildSearchFutureBuilder(String key) {
    return new FutureBuilder<HomeBean>(
      builder: (context, AsyncSnapshot<HomeBean> async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }

        if (async.connectionState == ConnectionState.done) {
          debugPrint('done');
          if (async.hasError) {
            return new Center(
              child: new Text('Error:code '),
            );
          } else if (async.hasData) {
            HomeBean bean = async.data;
            return new ArticleListView(
                bean.data.datas, ArticleType.NORMAL_ARTICLE, null);
          }
        }
      },
      future: getSearchData(key),
    );
  }

  Future<HomeBean> getSearchData(String key) async {
    var dio = new Dio();
    Response response = await dio.post(
      URL_SEARCH,
      options: Options(
        contentType: new ContentType('application', 'x-www-form-urlencoded',
            charset: 'utf-8'),
      ),
      data: {
        "k": key,
      },
    );
    HomeBean bean = HomeBean.fromJson(response.data);
    return bean;
  }

}

class SearchDefaultView extends StatelessWidget {
  final List<KeyNode> nodes;
  final callback;

  SearchDefaultView({this.nodes, this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        SearchDefaultItemView(
          nodes: nodes,
          callback: callback,
        ),
      ],
    );
  }
}

class SearchDefaultItemView extends StatelessWidget {
  final List<KeyNode> nodes;
  final callback;

  SearchDefaultItemView({this.nodes, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '大家都在搜',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.0,
            ),
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: nodes.map((childNode) {
                return GestureDetector(
                  child: new ClipRRect(
                    child: Container(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        childNode.getName(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                    ),
                    borderRadius: new BorderRadius.circular(3.0),
                  ),
                  onTap: () {
                    debugPrint('onTap key-> ${childNode.getName()}');
                    callback(childNode.getName());
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
