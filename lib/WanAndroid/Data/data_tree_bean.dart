import 'dart:convert' show json;

class TreeBean {
  int errorCode;
  String errorMsg;
  List<Node> nodes;

  TreeBean.fromParams(
      {this.errorCode, this.errorMsg, this.nodes,});

  factory TreeBean(jsonStr) =>
      jsonStr == null ? null : jsonStr is String ? new TreeBean
          .fromJson(json.decode(jsonStr)) : new TreeBean.fromJson(
          jsonStr);

  TreeBean.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    nodes = jsonRes['data'] == null ? null : [];

    for (var node in nodes == null ? [] : jsonRes['data']) {
      nodes.add(node == null ? null : new Node.fromJson(node));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class Node {

  int courseId;
  int mId;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;
  List<Node> childNodes;

  Node.fromParams(
      {this.courseId, this.mId, this.name, this.order, this.parentChapterId,
        this.userControlSetTop, this.visible,this.childNodes});

  factory Node(jsonStr) =>
      jsonStr == null ? null : jsonStr is String ? new Node
          .fromJson(json.decode(jsonStr)) : new Node.fromJson(
          jsonStr);

  Node.fromJson(jsonRes) {
    courseId = jsonRes['courseId'];
    mId = jsonRes['id'];
    name = jsonRes['name'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    userControlSetTop = jsonRes['userControlSetTop'];
    visible = jsonRes['visible'];
    childNodes = jsonRes['children'] == null ? null : [];

    for (var childNode in childNodes == null ? [] : jsonRes['children']) {
      childNodes.add(childNode == null ? null : new Node.fromJson(childNode));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
