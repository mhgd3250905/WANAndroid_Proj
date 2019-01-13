import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomizeDialog extends Dialog {
  final Widget widget;
  double width;
  double height;
  bool canceledOnTouchOutSide;

  CustomizeDialog({
    Key key,
    @required this.widget,
    @required this.width,
    @required this.height,
    this.canceledOnTouchOutSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: GestureDetector(
        onTap: () {
          //设置弹窗范围外点击是否返回
          if (!canceledOnTouchOutSide) {
            return;
          }
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              //设置点击弹窗范围内点击无响应
            },
            child: new Center(
              //保证控件居中效果
              child: new SizedBox(
                width: width,
                height: height,
                child: new Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: widget,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
