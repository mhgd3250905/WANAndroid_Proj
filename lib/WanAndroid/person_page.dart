import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_person_bean.dart';
import 'package:douban_movies/WanAndroid/bloc/AccountBloc.dart';
import 'package:douban_movies/WanAndroid/bloc/ApplicationBloc.dart';
import 'package:douban_movies/WanAndroid/bloc/bloc_utils.dart';
import 'package:douban_movies/WanAndroid/dialog_utils.dart';
import 'package:douban_movies/WanAndroid/icon_font_utils.dart';
import 'package:douban_movies/WanAndroid/sp_utils.dart';
import 'package:flutter/material.dart';

import 'config.dart';

Map<String, Color> themeColorMap = {
  'gray': Colors.grey,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.deepPurple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.deepOrange,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
};

class PersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc applicationbloc =
        BlocProvider.of<ApplicationBloc>(context);

    //构建菜单的方法
    getMenuItem(
        CircleAvatar iconAvatar, String title, void Function() onPress) {
      return InkWell(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.3))),
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
        ),
      );
    }

    Widget favoriteItemView = getMenuItem(
        CircleAvatar(
          child: Icon(Icons.favorite),
        ),
        '喜欢',
        null);

    Widget historyItemView = getMenuItem(
        CircleAvatar(
          child: Icon(Icons.history),
        ),
        '历史',
        null);

    Widget settingsItemView = getMenuItem(
        CircleAvatar(
          child: Icon(Icons.color_lens),
        ),
        '主题', () {
      showDialog<Null>(
          context: context, //BuildContext对象
          barrierDismissible: true,
          builder: (BuildContext context) {
            return new CustomizeDialog(
              canceledOnTouchOutSide: false,
              width: 300.0,
              height: 280.0,
              widget: Stack(
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
                    margin: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            '选择主题',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 200.0,
                          child: Center(
                            child: new Wrap(
                              children: themeColorMap.keys.map((String key) {
                                Color color = themeColorMap[key];
                                return new InkWell(
                                  onTap: () {
                                    applicationbloc.changeThemeSink
                                        .add(new ThemeData(
                                      primaryColor: color,
                                    ));
                                    SpUtils.save(SpUtils.KEY_PRIMARYCOLOR, color.value);
                                    Navigator.pop(context);
                                  },
                                  child: new Container(
                                    margin: EdgeInsets.all(5.0),
                                    width: 36.0,
                                    height: 36.0,
                                    color: color,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });

    final AccountBloc bloc = BlocProvider.of<AccountBloc>(context);

    return ListView(
      children: <Widget>[
        AccountWidget(
          bloc: bloc,
        ),
        favoriteItemView,
        historyItemView,
        settingsItemView,
      ],
    );
  }
}

class AccountWidget extends StatelessWidget {
  final AccountBloc bloc;

  AccountWidget({@required this.bloc});

  //获取用户头像需要显示的icon标识以及用户名的Widget
  getAccountWidget(BuildContext context, String account, Icon icon) {
    final accountController = new TextEditingController();
    final passwordController = new TextEditingController();
    var userName = account;
    if (userName == null || userName.length == 0) {
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
                      widget: account == null || account.length == 0
                          ? DialogLoginWidget(
                              bloc: bloc,
                              accountController: accountController,
                              passwordController: passwordController,
                            )
                          : DialogLogoutWidget(
                              bloc: bloc,
                            ),
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow,
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
      height: 200.0,
      alignment: const FractionalOffset(0.5, 0.5),
      child: Stack(
        children: <Widget>[
          StreamBuilder<String>(
              initialData: bloc.getAccount,
              stream: bloc.accountStream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return getAccountWidget(
                    context, snapshot.data, IconFontUtils.getIcon(0xe611));
              }),
        ],
      ),
    );
  }
}

class DialogLogoutWidget extends StatelessWidget {
  final AccountBloc bloc;

  DialogLogoutWidget({@required this.bloc});

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
          child: StreamBuilder(
            initialData: bloc.getAccount,
            stream: bloc.accountStream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.data == null) {
                new Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
                return new Container(
                  child: Center(
                    child: Text(
                      '注销成功',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 80.0,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: CircleAvatar(
                      child: Text(
                        snapshot.data.substring(0, 1).toUpperCase(),
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
                      snapshot.data,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  LogoutButton(
                    bloc: bloc,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class DialogLoginWidget extends StatelessWidget {
  final AccountBloc bloc;
  final accountController;
  final passwordController;

  DialogLoginWidget(
      {@required this.bloc,
      @required this.accountController,
      @required this.passwordController});

  @override
  Widget build(BuildContext context) {
//    final accountController = new TextEditingController();
//    final passwordController = new TextEditingController();
    return Stack(
      children: <Widget>[
        Container(
          alignment: const FractionalOffset(0.95, 0.05),
          child: GestureDetector(
            onTap: () {
              accountController.text = "";
              passwordController.text = "";
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
                bloc: bloc,
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
  final AccountBloc bloc;

  LoginButton(
      {@required this.account, @required this.password, @required this.bloc});

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
              widget.bloc.accountSaveSink.add(bean.data.username);
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
  final AccountBloc bloc;

  LogoutButton({@required this.bloc});

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
          widget.bloc.accountSaveSink.add("");
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
