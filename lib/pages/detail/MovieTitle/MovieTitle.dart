import 'package:flutter/material.dart';
import 'package:douban_movies/data/bean_move_detail.dart';
import 'package:douban_movies/pages/views/ClipImageView.dart';

///Movie Title block
class MovieTitleView extends StatelessWidget {
  final MovieDetail detail;

  MovieTitleView(this.detail);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Container(
            width: 100.0,
            child: new ClipImageView(
              detail.images.medium,
              new BorderRadius.circular(4.0),
            ),
          ),
          new MovieTitleContentItem(detail),
        ],
      ),
    );
  }
}

///Movie title 右边的内容区域
class MovieTitleContentItem extends StatelessWidget {
  final MovieDetail detail;

  MovieTitleContentItem(this.detail);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        padding: new EdgeInsets.only(
            left: 10.0, top: 5.0, right: 5.0, bottom: 5.0),
        child: new Column(
          children: <Widget>[

            /// Title
            new Container(
              width: double.infinity,
              child: new Text(
                detail.title,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),

            /// Title Top Desc
            new Container(
              margin: new EdgeInsets.only(top: 5.0, right: 5.0),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: new Text(
                detail.getTitleDescTop(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),

            ///Title Bottom Desc
            new Container(
              margin: new EdgeInsets.only(top: 5.0, right: 5.0),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: new Text(
                detail.getTitleDescBottom(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),

            /// Title Bottom Buttons
            getTitleButtons()
          ],
        ),
      ),
    );
  }

  ///get Title Block bottom buttons
  getTitleButtons() {
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
              flex: 1,
              child: new RaisedButton.icon(
                color: Colors.white,
                icon: new Icon(
                  Icons.favorite_border,
                  color: Colors.orange[400],
                ),
                label: new Text(
                  '想看',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  print('点击了按钮！');
                },
              )),
          new Padding(padding: new EdgeInsets.all(5.0)),
          new Expanded(
              flex: 1,
              child: new RaisedButton.icon(
                color: Colors.white,
                icon: new Icon(
                  Icons.star_border,
                  color: Colors.orange[400],
                ),
                label: new Text(
                  '看过',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  print('点击了按钮！');
                },
              )),
        ],
      ),
    );
  }
}