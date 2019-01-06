import 'dart:io';

import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';
import 'package:douban_movies/WanAndroid/Data/data_key_bean.dart';
import 'package:douban_movies/WanAndroid/article_list_content.dart';
import 'package:flutter/material.dart';

import 'article_page.dart';

final String URL_HOT_KEY = 'http://www.wanandroid.com/hotkey/json';
final String URL_SEARCH = 'http://www.wanandroid.com/article/query/0/json';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

String _keyStr = "";

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = new TextEditingController();
  final FocusNode focusNode = new FocusNode();
  Widget contentWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _keyStr = "";
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_SearchPageState key-> ${_keyStr}');
    if (contentWidget == null) {
      contentWidget = SearchContentView(
        keyStr: _keyStr,
        callback: () => searchKey(),
      );
    }
    return new Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 35.0),
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              autofocus: false,
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '搜索一下吧.',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                    size: 25.0,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                suffixIcon: GestureDetector(
                  child: Icon(
                    Icons.search,
                    color: Colors.blue,
                    size: 25.0,
                  ),
                  onTap: () {
                    debugPrint('search key-> ${controller.text}');
                    _keyStr = controller.text;
                    searchKey();
                  },
                ),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: contentWidget,
    );
  }

  void searchKey() {
    debugPrint('$_keyStr');
    focusNode.unfocus();
    setState(() {
      contentWidget = SearchContentView(
        keyStr: _keyStr,
        callback: () => searchKey(),
      );
    });
  }
}

class SearchTextField extends StatelessWidget {
  final GestureTapCallback onSearchTap;
  final TextEditingController controller;
  final FocusNode focusNode;

  SearchTextField(this.controller, this.onSearchTap, this.focusNode);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        autofocus: false,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '搜索一下吧.',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 30.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.search,
              color: Colors.blue,
              size: 30.0,
            ),
            onTap: onSearchTap,
          ),
        ),
      ),
    );
  }
}

class SearchContentView extends StatefulWidget {
  final String keyStr;
  final callback;
  Widget defaultContent;

  SearchContentView({@required this.keyStr, this.callback});

  @override
  _SearchContentViewState createState() => _SearchContentViewState();
}

class _SearchContentViewState extends State<SearchContentView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.keyStr == ""
        ? widget.defaultContent != null
            ? widget.defaultContent
            : buildDefaultFutureBuilder()
        : buildSearchFutureBuilder();
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
            widget.defaultContent = new SearchDefaultView(
              nodes: bean.nodes,
              callback: widget.callback,
            );
            return widget.defaultContent;
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

  FutureBuilder<HomeBean> buildSearchFutureBuilder() {
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
      future: getSearchData(),
    );
  }

  Future<HomeBean> getSearchData() async {
    debugPrint('getHomeBeanData');
    var dio = new Dio();
    Response response = await dio.post(
      URL_SEARCH,
      options: Options(
        contentType: new ContentType('application', 'x-www-form-urlencoded',
            charset: 'utf-8'),
      ),
      data: {
        "k": widget.keyStr,
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
    // TODO: implement build

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
                    _keyStr = childNode.getName();
                    callback();
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
