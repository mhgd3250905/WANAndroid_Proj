import 'dart:io';

import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_navi_bean.dart';
import 'package:douban_movies/WanAndroid/dialog_utils.dart';
import 'package:douban_movies/WanAndroid/icon_font_utils.dart';
import 'package:flutter/material.dart';
import 'package:douban_movies/WanAndroid/config.dart';
import 'package:cookie_jar/cookie_jar.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    //构建菜单的方法
    getMenuItem(CircleAvatar iconAvatar, String title) {
      return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3))),
        padding: const EdgeInsets.all(10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: iconAvatar,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget accountItemView = Container(
      decoration: BoxDecoration(
          color: Colors.yellow,
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
      height: 200.0,
      alignment: const FractionalOffset(0.5, 0.5),
      child: Stack(
        children: <Widget>[
          getAccountWidget('未登录', IconFontUtils.getIcon(0xe611)),
        ],
      ),
    );

    Widget favoriteItemView = getMenuItem(
        CircleAvatar(
          child: Icon(Icons.favorite),
        ),
        '喜欢');

    Widget historyItemView = getMenuItem(
        CircleAvatar(
          child: Icon(Icons.history),
        ),
        '历史');

    return ListView(
      children: <Widget>[
        accountItemView,
        favoriteItemView,
        historyItemView,
      ],
    );
  }

  /**
   * 获取用户头像需要显示的icon标识以及用户名的Widget
   */
  getAccountWidget(String userName, Icon icon) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              showDialog<Null>(
                  context: context, //BuildContext对象
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return new CustomizeDialog(
                      canceledOnTouchOutSide: true,
                      width: 300.0,
                      height: 260.0,
                      widget: DialogWidget(),
                    );
                  });
            },
            child: Container(
              width: 80.0,
              height: 80.0,
              child: CircleAvatar(
                child: icon == null
                    ? Text(
                        userName.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : icon,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              userName,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 1.0),
                      spreadRadius: 2.0,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogWidget extends StatefulWidget {
  @override
  _DialogWidgetState createState() => new _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  bool _isLogin = false;
  var accountController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogin = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(10.0),
            child: Text(
              '登录',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: TextField(
              controller: accountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入账号',
                prefixIcon: IconFontUtils.getIcon(0xe678),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入密码',
                prefixIcon: IconFontUtils.getIcon(0xe609),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
            height: 40.0,
            width: double.infinity,
            child: RaisedButton(
              color: Colors.blue,
              elevation: 0.0,
              onPressed: () {
              },
              child: Text(
                '登录',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
    Response response = await dio.post(
      URL_LOGIN,
      options: Options(
        contentType: new ContentType('application', 'x-www-form-urlencoded',
            charset: 'utf-8'),
      ),
      data: {
        'username': 'mhgd3250901',
        'password': '3250905',
      },
    );
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
