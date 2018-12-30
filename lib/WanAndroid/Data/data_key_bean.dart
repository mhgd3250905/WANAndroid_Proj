import 'dart:convert' show json;

class KeyBean {
  int errorCode;
  String errorMsg;
  List<KeyNode> nodes;

  KeyBean.fromParams({
    this.errorCode,
    this.errorMsg,
    this.nodes,
  });

  factory KeyBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new KeyBean.fromJson(json.decode(jsonStr))
          : new KeyBean.fromJson(jsonStr);

  KeyBean.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    nodes = jsonRes['data'] == null ? null : [];

    for (var node in nodes == null ? [] : jsonRes['data']) {
      nodes.add(node == null ? null : new KeyNode.fromJson(node));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class KeyNode {
  int mid;
  String link;
  String name;
  int order;
  int visible;

  KeyNode.fromParams(
      {this.mid, this.link, this.name, this.order, this.visible});

  factory KeyNode(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new KeyNode.fromJson(json.decode(jsonStr))
          : new KeyNode.fromJson(jsonStr);

  KeyNode.fromJson(jsonRes) {
    mid = jsonRes['id'];
    link = jsonRes['link'];
    name = jsonRes['name'];
    order = jsonRes['order'];
    visible = jsonRes['visible'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
