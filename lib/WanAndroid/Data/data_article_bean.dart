import 'dart:convert' show json;

import 'package:html_unescape/html_unescape.dart';

class HomeBean {
  int errorCode;
  String errorMsg;
  HomeListBean data;

  HomeBean.fromParams({
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  factory HomeBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new HomeBean.fromJson(json.decode(jsonStr))
          : new HomeBean.fromJson(jsonStr);

  HomeBean.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null
        ? null
        : new HomeListBean.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class HomeListBean {
  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<Data> datas;

  HomeListBean.fromParams(
      {this.curPage,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total,
      this.datas});

  factory HomeListBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new HomeListBean.fromJson(json.decode(jsonStr))
          : new HomeListBean.fromJson(jsonStr);

  HomeListBean.fromJson(jsonRes) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    over = jsonRes['over'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var data in datas == null ? [] : jsonRes['datas']) {
      datas.add(data == null ? null : new Data.fromJson(data));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class Data {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int mId;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<Tag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  getTitle() {
    var unescape = new HtmlUnescape();
    return unescape.convert(title);
  }

  getChapterName() {
    var unescape = new HtmlUnescape();
    return unescape.convert(chapterName);
  }

  getNiceDate() {
    var unescape = new HtmlUnescape();
    return unescape.convert(niceDate);
  }

  Data.fromParams({
    this.apkLink,
    this.author,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.envelopePic,
    this.fresh,
    this.mId,
    this.link,
    this.niceDate,
    this.origin,
    this.projectLink,
    this.publishTime,
    this.superChapterId,
    this.superChapterName,
    this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  });

  Data.fromJson(jsonRes) {
    apkLink = jsonRes['apkLink'];
    author = jsonRes['author'];
    chapterId = jsonRes['chapterId'];
    chapterName = jsonRes['chapterName'];
    collect = jsonRes['collect'];
    courseId = jsonRes['courseId'];
    desc = jsonRes['desc'];
    envelopePic = jsonRes['envelopePic'];
    fresh = jsonRes['fresh'];
    mId = jsonRes['id'];
    link = jsonRes['link'];
    niceDate = jsonRes['niceDate'];
    origin = jsonRes['origin'];
    projectLink = jsonRes['projectLink'];
    publishTime = jsonRes['publishTime'];
    superChapterId = jsonRes['superChapterId'];
    superChapterName = jsonRes['superChapterName'];
    tags = jsonRes['tags'] == null ? null : [];
    title = jsonRes['title'];
    type = jsonRes['type'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    zan = jsonRes['zan'];
  }

  Map<String, dynamic> toJson() => {
        'apkLink': apkLink,
        'author': author,
        'chapterId': chapterId,
        'chapterName': chapterName,
        'collect': collect,
        'courseId': courseId,
        'desc': desc,
        'envelopePic': envelopePic,
        'fresh': fresh,
        'id': mId,
        'link': link,
        'niceDate': niceDate,
        'origin': origin,
        'projectLink': projectLink,
        'publishTime': publishTime,
        'superChapterId': superChapterId,
        'superChapterName': superChapterName,
        'tags': tags,
        'title': title,
        'type': type,
        'userId': userId,
        'visible': visible,
        'zan': zan,
      };
}

class Tag {
  String name;
  String url;

  Tag.fromParams({
    this.name,
    this.url,
  });

  Tag.fromJson(jsonRes) {
    name = jsonRes['name'];
    url = jsonRes['url'];
  }
}
