import 'dart:convert' show json;

class PersonBean {

  int errorCode;
  String errorMsg;
  detail data;

  PersonBean.fromParams({this.errorCode, this.errorMsg, this.data});

  factory PersonBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new PersonBean.fromJson(json.decode(jsonStr)) : new PersonBean.fromJson(jsonStr);

  PersonBean.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : new detail.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class detail {

  int id;
  int type;
  String email;
  String icon;
  String password;
  String token;
  String username;
  List<dynamic> chapterTops;
  List<dynamic> collectIds;

  detail.fromParams({this.id, this.type, this.email, this.icon, this.password, this.token, this.username, this.chapterTops, this.collectIds});

  detail.fromJson(jsonRes) {
    id = jsonRes['id'];
    type = jsonRes['type'];
    email = jsonRes['email'];
    icon = jsonRes['icon'];
    password = jsonRes['password'];
    token = jsonRes['token'];
    username = jsonRes['username'];
    chapterTops = jsonRes['chapterTops'] == null ? null : [];

    for (var chapterTopsItem in chapterTops == null ? [] : jsonRes['chapterTops']){
      chapterTops.add(chapterTopsItem);
    }

    collectIds = jsonRes['collectIds'] == null ? null : [];

    for (var collectIdsItem in collectIds == null ? [] : jsonRes['collectIds']){
      collectIds.add(collectIdsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"type": $type,"email": ${email != null?'${json.encode(email)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"password": ${password != null?'${json.encode(password)}':'null'},"token": ${token != null?'${json.encode(token)}':'null'},"username": ${username != null?'${json.encode(username)}':'null'},"chapterTops": $chapterTops,"collectIds": $collectIds}';
  }
}

