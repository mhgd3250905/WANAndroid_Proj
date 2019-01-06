import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_tree_bean.dart';
import 'package:douban_movies/WanAndroid/article_page.dart';
import 'package:douban_movies/WanAndroid/navigator_router_utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';

final String URL_TREE_LIST = 'http://www.wanandroid.com/project/tree/json';

getRandomColor() {
  return Color.fromARGB(255, Random.secure().nextInt(255),
      Random.secure().nextInt(255), Random.secure().nextInt(255));
}

class ProjectTreePage extends StatefulWidget {
  @override
  _ProjectTreePageState createState() => new _ProjectTreePageState();
}

class _ProjectTreePageState extends State<ProjectTreePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildFutureBuilder();
  }

  FutureBuilder<TreeBean> buildFutureBuilder() {
    return new FutureBuilder<TreeBean>(
      builder: (context, AsyncSnapshot<TreeBean> async) {
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
            TreeBean bean = async.data;
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

  Future<TreeBean> getData() async {
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(URL_TREE_LIST);
    TreeBean bean = TreeBean.fromJson(response.data);
    return bean;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ContentView extends StatelessWidget {
  final List<Node> nodes;

  ContentView(this.nodes);

  void jump2AtriclePage(int id) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return ListView.builder(
//      itemBuilder: (context, i) {
//        return new ContentItemView(nodes[i]);
//      },
//      itemCount: nodes.length,
//      scrollDirection: Axis.vertical,
//    );
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(10.0),
      children: nodes.map((node) {
        return ProjectItemView(
          node: node,
        );
      }).toList(),
    );
  }
}

class ProjectItemView extends StatelessWidget {
  final Node node;

  ProjectItemView({this.node});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: getRandomColor(),
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
      ),
      elevation: 2.5,
      child: InkWell(
        onTap: () {
          NavigatorRouterUtils.pushToPage(
              context,
              new ArticlePage(
                name: node.getName(),
                id: node.mId,
                type: ArticleType.PROJECT_ARTICLE,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              node.getName(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white,
                shadows: [
                  BoxShadow(color: Colors.grey, offset: Offset(0.5, 0.5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContentItemView extends StatelessWidget {
  final Node node;

  ContentItemView(this.node);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 0.3,
      child: InkWell(
        onTap: () {
          NavigatorRouterUtils.pushToPage(
              context,
              new ArticlePage(
                name: node.getName(),
                id: node.mId,
                type: ArticleType.PROJECT_ARTICLE,
              ));
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  node.getName(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
