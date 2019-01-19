import 'dart:io';

import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_navi_bean.dart';
import 'package:douban_movies/WanAndroid/Data/data_person_bean.dart';
import 'package:douban_movies/WanAndroid/dialog_utils.dart';
import 'package:douban_movies/WanAndroid/icon_font_utils.dart';
import 'package:douban_movies/WanAndroid/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:douban_movies/WanAndroid/config.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

String account;
final subject = new PublishSubject<String>();

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subject.stream
        .debounce(new Duration(milliseconds: 600))
        .listen(_textChanged);
  }

  void _textChanged(String text) {
    setState(() {
      account = text;
    });
  }

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
        AccountWidget(),
        favoriteItemView,
        historyItemView,
      ],
    );
  }
}

//账户widget
class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => new _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  //获取用户头像需要显示的icon标识以及用户名的Widget
  getAccountWidget(String userName, Icon icon) {
    if (userName == null||userName.length==0) {
      userName = "未登录";
    }
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
                      canceledOnTouchOutSide: false,
                      width: 300.0,
                      height: 280.0,
                      widget: account == null||account.length==0
                          ? DialogLoginWidget()
                          : DialogLogoutWidget(),
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

  @override
  void initState() {
    getSpResult();
  }

  getSpResult() async {
    account = await SpUtils.getString(SpUtils.KEY_ACCOUNT, "");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow,
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
      height: 200.0,
      alignment: const FractionalOffset(0.5, 0.5),
      child: Stack(
        children: <Widget>[
          getAccountWidget(account, IconFontUtils.getIcon(0xe611)),
        ],
      ),
    );
  }
}

class DialogLogoutWidget extends StatelessWidget {
  final String account;

  DialogLogoutWidget({this.account});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Container(
          alignment: const FractionalOffset(0.95, 0.05),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                margin: const EdgeInsets.only(bottom: 10.0),
                child: CircleAvatar(
                  child: Text(
                    "mhgd3250905".substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "mhgd3250905",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              LogoutButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class DialogLoginWidget extends StatefulWidget {
  @override
  _DialogLoginWidgetState createState() => new _DialogLoginWidgetState();
}

class _DialogLoginWidgetState extends State<DialogLoginWidget> {
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
    return Stack(
      children: <Widget>[
        Container(
          alignment: const FractionalOffset(0.95, 0.05),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              LoginButton(
                account: accountController.text,
                password: passwordController.text,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoginButton extends StatefulWidget {
  final String account;
  final String password;

  LoginButton({this.account, this.password});

  @override
  _LoginButtonState createState() => new _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isSendRequest = false;

  FutureBuilder<PersonBean> buildFutureBuilder() {
    return new FutureBuilder<PersonBean>(
      builder: (context, AsyncSnapshot<PersonBean> async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return getDefaultButton(
            false,
            Text(
              '登录中...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        if (async.connectionState == ConnectionState.done) {
          debugPrint('done');
          if (async.hasError) {
            isSendRequest = false;
            return getDefaultButton(
              true,
              Text(
                '登录失败',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (async.hasData) {
            isSendRequest = false;
            PersonBean bean = async.data;
            if (bean.errorCode != 0) {
              return getDefaultButton(
                true,
                Text(
                  '登录失败',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              isSendRequest = false;
              new Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context);
              });
              SpUtils.save(SpUtils.KEY_ACCOUNT, bean.data.username);
              subject.add(bean.data.username);
              return getDefaultButton(
                true,
                Text(
                  '登录成功',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          }
        }
      },
      future: getData(),
    );
  }

  Future<PersonBean> getData() async {
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.post(
      URL_LOGIN,
      options: Options(
        contentType: new ContentType('application', 'x-www-form-urlencoded',
            charset: 'utf-8'),
      ),
      data: {
        'username': widget.account,
        'password': widget.password,
      },
    );
    PersonBean bean = PersonBean.fromJson(response.data);
    return bean;
  }

  getDefaultButton(bool pressable, Widget innerWidget) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      height: 50.0,
      width: double.infinity,
      child: GestureDetector(
        onTap: pressable
            ? () {
                isSendRequest = true;
                setState(() {});
              }
            : () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: innerWidget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isSendRequest
        ? buildFutureBuilder()
        : getDefaultButton(
            true,
            Text(
              '点击登录',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}

class LogoutButton extends StatefulWidget {

  LogoutButton();

  @override
  _LogoutButtonState createState() => new _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  getDefaultButton(Widget innerWidget) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      height: 50.0,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          SpUtils.remove(SpUtils.KEY_ACCOUNT);
          subject.add(null);
          new Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: innerWidget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getDefaultButton(
      Text(
        '点击注销',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
