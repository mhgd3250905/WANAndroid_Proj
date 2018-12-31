import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';
import 'package:douban_movies/pages/views/ClipImageView.dart';
import 'package:flutter/material.dart';
import 'package:douban_movies/WanAndroid/navigator_router_utils.dart';
import 'package:douban_movies/WanAndroid/article_detail_page.dart';
import 'article_page.dart';
import 'config.dart';

class ArticleListPage extends StatefulWidget {
  String url;
  List<Data> mDataList = [];
  final ArticleType type;
  final int id;
  ScrollController scrollController = new ScrollController();
  GlobalKey<RefreshIndicatorState> _refreshIndicaterState =
      GlobalKey<RefreshIndicatorState>();

  ArticleListPage({this.type, this.id});

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetUrl();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  //重置Page参数
  void resetUrl() {
    switch (widget.type) {
      case ArticleType.HOME_ARTICLE:
        widget.url = URL_HOME_ARTICLE_LIST_part_1 +
            page.toString() +
            URL_HOME_ARTICLE_LIST_part_2;
        break;
      case ArticleType.NORMAL_ARTICLE:
        widget.url = URL_TREE_ARTICLE_LIST_part_1 +
            page.toString() +
            URL_TREE_ARTICLE_LIST_part_2 +
            widget.id.toString();
        break;
      case ArticleType.PROJECT_ARTICLE:
        widget.url = URL_PROJECT_ARTICLE_LIST_part_1 +
            page.toString() +
            URL_PROJECT_ARTICLE_LIST_part_2 +
            widget.id.toString();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    debugPrint('${widget.mDataList.length}');
    return widget.mDataList.length == 0
        ? buildFutureBuilder()
        : RefreshIndicator(
            key: widget._refreshIndicaterState,
            child: getListView(
                widget.mDataList, widget.type, widget.scrollController),
            onRefresh: resetData,
          );
  }

  getListView(
      List<Data> datas, ArticleType type, ScrollController scrollContriller) {
    return new ArticleListView(datas, type, scrollContriller);
  }

  FutureBuilder<HomeBean> buildFutureBuilder() {
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
            widget.mDataList.addAll(bean.data.datas);
            return RefreshIndicator(
              key: widget._refreshIndicaterState,
              child: getListView(
                  widget.mDataList, widget.type, widget.scrollController),
              onRefresh: () {},
            );
          }
        }
      },
      future: getData(),
    );
  }

  Future<HomeBean> getMoreData() async {
    page++;
    resetUrl();
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(widget.url);
    HomeBean bean = HomeBean.fromJson(response.data);
    widget.mDataList.addAll(bean.data.datas);
    setState(() {});
  }

  Future<HomeBean> resetData() async {
    page = 0;
    resetUrl();
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(widget.url);
    HomeBean bean = HomeBean.fromJson(response.data);
    widget.mDataList.clear();
    widget.mDataList.addAll(bean.data.datas);
    setState(() {});
  }

  Future<HomeBean> getData() async {
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(widget.url);
    HomeBean bean = HomeBean.fromJson(response.data);
    return bean;
  }
}

class ArticleListView extends StatelessWidget {
  final List<Data> datas;
  final ArticleType type;
  final ScrollController scrollController;

  ArticleListView(this.datas, this.type, this.scrollController);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: datas.length,
      itemBuilder: (BuildContext context, int i) {
        return new Container(
          child: Column(
            children: <Widget>[
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey,width: 0.3)),
                  ),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: getContentItem(i),
                ),
                onTap: () {
                  NavigatorRouterUtils.pushToPage(
                    context,
                    ArticleDetailPage(
                      data: datas[i],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      scrollDirection: Axis.vertical,
    );
  }

  getContentItem(int i) {
    if (datas[i].envelopePic == "") {
      return ArticleItemView(datas[i]);
    } else {
      return ProjectItemView(datas[i]);
    }
  }
}

class ArticleItemView extends StatefulWidget {
  final Data data;

  ArticleItemView(this.data);

  @override
  _ArticleItemViewState createState() => new _ArticleItemViewState();
}

class _ArticleItemViewState extends State<ArticleItemView> {
  bool isCollected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void changeItemCollect() {
    if (isCollected) {
      isCollected = false;
    } else {
      isCollected = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 3.0),
                alignment: Alignment.centerLeft,
                child: new Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                  size: 14.0,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.data.author == null ? "" : widget.data.author,
                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                ),
              ),
              new Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 3.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.data.niceDate == null ? "" : widget.data.niceDate,
                    style: TextStyle(fontSize: 13.0, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              widget.data.title,
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          new Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  widget.data.chapterName,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
              ),
              new Expanded(
                  child: new Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    icon: new Icon(
                      isCollected ? Icons.favorite : Icons.favorite_border,
                      color: isCollected ? Colors.blue : Colors.grey[400],
                      size: 20.0,
                    ),
                    onPressed: () {
                      changeItemCollect();
                    }),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectItemView extends StatefulWidget {
  final Data data;

  ProjectItemView(this.data);

  @override
  _ProjectItemViewState createState() => new _ProjectItemViewState();
}

class _ProjectItemViewState extends State<ProjectItemView> {
  bool isCollected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void changeItemCollect() {
    if (isCollected) {
      isCollected = false;
    } else {
      isCollected = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      alignment: Alignment.centerLeft,
      height: 200.0,
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 5.0),
            width: 100.0,
            child: ClipImageView(
                widget.data.envelopePic, BorderRadius.circular(3.0)),
          ),
          Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: new Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text(
                          widget.data.title,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          alignment: Alignment.topLeft,
                          width: double.infinity,
                          child: Text(
                            widget.data.title,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        widget.data.chapterName,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    new Expanded(
                        child: new Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          icon: new Icon(
                            isCollected
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isCollected ? Colors.blue : Colors.grey[400],
                            size: 20.0,
                          ),
                          onPressed: () {
                            changeItemCollect();
                          }),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
