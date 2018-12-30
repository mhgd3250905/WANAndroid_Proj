import 'dart:math';

import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_navi_bean.dart';
import 'package:douban_movies/WanAndroid/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:douban_movies/WanAndroid/navigator_router_utils.dart';

final String URL_NAVI_LIST = 'http://www.wanandroid.com/navi/json';

class PopularContentView extends StatefulWidget {
  @override
  _PopularContentViewState createState() => _PopularContentViewState();
}

class _PopularContentViewState extends State<PopularContentView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildFutureBuilder();
  }

  FutureBuilder<NaviBean> buildFutureBuilder() {
    return new FutureBuilder<NaviBean>(
      builder: (context, AsyncSnapshot<NaviBean> async) {
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
            NaviBean bean = async.data;
            return RefreshIndicator(
              child: new ContentView(bean.nodes),
              onRefresh: () {},
            );
          }
        }
      },
      future: getData(),
    );
  }

  Future<NaviBean> getData() async {
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(URL_NAVI_LIST);
    NaviBean bean = NaviBean.fromJson(response.data);
    return bean;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ContentView extends StatelessWidget {
  final List<NaviNode> nodes;

  ContentView(this.nodes);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: nodes.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          return ContentItemView(nodes[i]);
        });
  }
}

class ContentItemView extends StatelessWidget {
  final NaviNode naviNode;

  ContentItemView(this.naviNode);

  getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 0.3,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                naviNode.name,
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
                children: naviNode.articles.map((childNode) {
                  return GestureDetector(
                    child: new ClipRRect(
                      child: Container(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          childNode.title,
                          style: TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.grey, offset: Offset(0.2, 0.2))
                            ],
                          ),
                        ),
                        color: getRandomColor(),
                      ),
                      borderRadius: new BorderRadius.circular(3.0),
                    ),
                    onTap: () {
                      NavigatorRouterUtils.pushToPage(
                        context, ArticleDetailPage(
                        data: childNode,
                      ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
