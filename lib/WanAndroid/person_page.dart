import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_navi_bean.dart';
import 'package:flutter/material.dart';

final String URL_NAVI_LIST = 'http://www.wanandroid.com/navi/json';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        accountItemView,
        articleBoxItemView,
      ],
    );
  }

  Widget accountItemView = Container(
    decoration:
        BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'mhgd3250905',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        new Expanded(child: Container()),
        new Text(
          '注销',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 15.0,
          ),
        ),
      ],
    ),
  );

  Widget articleBoxItemView = Container(
    color: Colors.white,
    margin: EdgeInsets.all(10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  color: Colors.grey[800],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: new Text(
                    '收藏',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.history,
                  color: Colors.grey[800],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: new Text(
                    '历史',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  FutureBuilder<NaviBean> buildFutureBuilder() {
    return new FutureBuilder<NaviBean>(
      builder: (context, AsyncSnapshot<NaviBean> async) {
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
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      borderRadius: new BorderRadius.circular(3.0),
                    ),
                    onTap: () {},
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
