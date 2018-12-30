import 'package:flutter/material.dart';

class StarItem extends StatelessWidget {
  final int _startCount;
  final double _starSize;
  final Color _starColor;
  final bool _hasBorderStar;

  StarItem(
      this._startCount, this._starSize, this._starColor, this._hasBorderStar);

  @override
  Widget build(BuildContext context) {
    return getStarView(_startCount, _starSize, _starColor, _hasBorderStar);
  }
}

getStarView(int starts, double starSize, Color starColor, bool hasBorderStar) {
  //获取半实心Start的数量
  int halfStarCount = starts % 10 == 0 ? 0 : 1;
  //获取实心Start的数量
  int fullStartCount = starts ~/ 10;

  List<Widget> starList = <Widget>[];

  for (var i = 0; i < fullStartCount; i++) {
    starList.add(new Icon(
      Icons.star,
      color: starColor,
      size: starSize,
    ));
  }

  if (halfStarCount != 0) {
    starList.add(new Icon(
      Icons.star_half,
      color: starColor,
      size: starSize,
    ));
  }

  if (hasBorderStar) {
    int borderStartCount=halfStarCount!=0?4 - fullStartCount:5-fullStartCount;
    for (var i = 0; i < borderStartCount; i++) {
      starList.add(new Icon(
        Icons.star_border,
        color: starColor,
        size: starSize,
      ));
    }
  }

  return new Row(
    children: starList,
  );
}
