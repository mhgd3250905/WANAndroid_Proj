import 'package:douban_movies/WanAndroid/navigator_router_utils.dart';
import 'package:douban_movies/data/bean_move_list.dart';
import 'package:douban_movies/net/http.dart';
import 'package:douban_movies/pages/detail/page_detail.dart';
import 'package:douban_movies/pages/views/ClipImageView.dart';
import 'package:douban_movies/res/value_string.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'views/StartsView.dart';

final List<Tab> tabs = <Tab>[
  new Tab(text: '正在热映'),
  new Tab(text: '即将上映'),
  new Tab(text: 'Top250'),
//  new Tab(text: '口碑榜'),
//  new Tab(text: '北美票房榜'),
  new Tab(text: '新片榜'),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: AppStrings.AppName,
      home: new DefaultTabController(
        length: tabs.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(AppStrings.HomePageAppBarTitle),
            bottom: new TabBar(
              tabs: tabs,
              isScrollable: true,
            ),
          ),
          body: new TabBarView(
            children: tabs.map((Tab tab) {
              return HomeContent(tab);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/**
 * 创建显示在首页的内容
 */
class HomeContent extends StatefulWidget {
  final Tab _tab;

  HomeContent(this._tab);

  @override
  _HomeContentState createState() => _HomeContentState(_tab);
}

class _HomeContentState extends State<HomeContent>
    with AutomaticKeepAliveClientMixin {
  final Tab _tab;
  List<subject> _subjects = new List();
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicaterState =
      GlobalKey<RefreshIndicatorState>();
  int start = 0;
  int limit = 25;
  int page = 0;

  _HomeContentState(this._tab);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
    _loadData();
    new Future.delayed(const Duration(seconds: 0), () {
      _refreshIndicaterState.currentState.show().then((e) {});
      return true;
    });
  }

  //获取电影列表
  Future<Null> _loadData() async {
    page = 0;
    String url = HttpUtils.URL_GET_MOVIE_LIST_IN_THEATERS;
    Map map = {
      'apikey': HttpUtils.URL_API_KEY,
      'udid': HttpUtils.URL_UDID,
      'city': '上海',
      'client': '',
      'start': start + page * limit,
      'count': limit
    };
    switch (_tab.text) {
      case '正在热映':
        url = HttpUtils.URL_GET_MOVIE_LIST_IN_THEATERS;
        break;
      case '即将上映':
        url = HttpUtils.URL_GET_MOVIE_LIST_COMING_SOON;
        break;
      case 'Top250':
        url = HttpUtils.URL_GET_MOVIE_LIST_TOP_250;
        break;
      case '口碑榜':
        url = HttpUtils.URL_GET_MOVIE_LIST_WEEKLY;
        map = {
          'apikey': HttpUtils.URL_API_KEY,
          'udid': '',
          'city': '上海',
          'client': '',
        };
        break;
      case '北美票房榜':
        url = HttpUtils.URL_GET_MOVIE_LIST_US_BOX;
        map = {
          'apikey': HttpUtils.URL_API_KEY,
          'udid': '',
          'client': '',
        };
        break;
      case '新片榜':
        url = HttpUtils.URL_GET_MOVIE_LIST_NEW_MOVIES;
        map = {
          'apikey': HttpUtils.URL_API_KEY,
          'udid': '',
          'client': '',
        };
        break;
    }
    var datas = await HttpUtils.get(
      url,
      map: map,
    );
    MovieList moveList = new MovieList(datas);
    _subjects = moveList.subjects;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      key: _refreshIndicaterState,
      child: new Container(
        child: new ListView.builder(
//          physics: new AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _subjects.length,
          itemBuilder: (context, i) {
            if (i.isOdd) return new Divider();
            int index = i ~/ 2;
            return new Container(
              margin: EdgeInsets.only(top: i == 0 ? 10.0 : 0),
              child: new MoveItem(_subjects[index]),
            );
          },
        ),
      ),
      onRefresh: _loadData,
    );
  }

  void _getMore() async {
    page++;
    print('$page');
    String url = HttpUtils.URL_GET_MOVIE_LIST_IN_THEATERS;
    bool canGetMore = true;
    switch (_tab.text) {
      case '正在热映':
        url = HttpUtils.URL_GET_MOVIE_LIST_IN_THEATERS;
        break;
      case '即将上映':
        url = HttpUtils.URL_GET_MOVIE_LIST_COMING_SOON;
        break;
      case 'Top250':
        url = HttpUtils.URL_GET_MOVIE_LIST_TOP_250;
        break;
      case '口碑榜':
        canGetMore = false;
        url = HttpUtils.URL_GET_MOVIE_LIST_WEEKLY;
        break;
      case '北美票房榜':
        canGetMore = false;
        url = HttpUtils.URL_GET_MOVIE_LIST_US_BOX;
        break;
      case '新片榜':
        canGetMore = false;
        url = HttpUtils.URL_GET_MOVIE_LIST_NEW_MOVIES;
        break;
    }
    if (canGetMore) {
      var datas = await HttpUtils.get(url, map: {
        'apikey': HttpUtils.URL_API_KEY,
        'udid': HttpUtils.URL_UDID,
        'city': '上海',
        'client': '',
        'start': start + page * limit,
        'count': limit
      });
      MovieList moveList = new MovieList(datas);
      _subjects.addAll(moveList.subjects);
    }
    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MoveItem extends StatelessWidget {
  final subject subjectData;

  MoveItem(this.subjectData);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        NavigatorRouterUtils.pushToPage(context, new DetailPage(subjectData));
      },
      child: new Row(
        children: <Widget>[
          new Container(
            width: 110.0,
            padding: EdgeInsets.only(left: 10.0),
            //使用图片渐入框架
            child: ClipImageView(
                subjectData.images.medium, new BorderRadius.circular(4.0)),
          ),
          new Expanded(
            child: new Container(
              height: 150.0,
              padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: double.infinity,
                    child: new Text(
                      subjectData.title,
                      style: new TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  getRatingItem(subjectData),
                  new Container(
                    margin: new EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    child: new Text(
                      '${MovieList.getDetailDesc(subjectData)}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
//                  new Expanded(
//                    child: new Container(
//                      padding: new EdgeInsets.only(top:10.0),
//                      child: new CastsView(subjectData.casts),
//                    ),
//                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getRatingItem(subject subjectData) {
    return int.parse(subjectData.rating.stars) == 0
        ? new Container(
            width: double.infinity,
            margin: new EdgeInsets.only(top: 10.0),
            child: Text(
              '暂无评分',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          )
        : new Container(
            margin: new EdgeInsets.only(top: 10.0),
            child: new Row(
              children: <Widget>[
                new StarItem(int.parse(subjectData.rating.stars), 15.0,
                    Colors.orange[300], true),
                new Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: new Text(
                    '${subjectData.rating.average}',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class CastsView extends StatelessWidget {
  final List<cast> casts;

  CastsView(this.casts);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return casts == null
        ? new Container()
        : new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            itemBuilder: (context, i) {
              return new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(
                        left: i != 0 ? 10.0 : 0.0, top: 5.0),
                    child: new ClipOval(
                      child: new FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        fit: BoxFit.fitWidth,
                        image: casts[i].avatars.small,
                        height: 45.0,
                        width: 45.0,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
  }
}
