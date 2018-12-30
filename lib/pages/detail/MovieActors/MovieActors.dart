import 'package:flutter/material.dart';
import 'package:douban_movies/data/bean_move_detail.dart';
import 'package:douban_movies/pages/views/ClipImageView.dart';

class MovieActorsView extends StatelessWidget {

  final MovieDetail detail;

  MovieActorsView(this.detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            child: new Text('影人',
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Container(
            height: 160.0,
            margin: EdgeInsets.only(top: 10.0),
            child: new Row(
              children: <Widget>[
                getActorsListView(detail.casts),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getActorsListView(List<cast> casts) {
    return new Expanded(
      child: new ListView.builder(
        itemBuilder: (c, i) {
          return new Container(
            width: 85.0,
            child: new Column(
              children: <Widget>[
                new ClipImageView(
                  casts[i].avatars.small,
                  new BorderRadius.circular(4.0),
                ),
                new Container(
                  width: double.infinity,
                  child: new Text(
                    '${casts[i].name}',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
                new Container(
                  width: double.infinity,
                  child: new Text(
                    '${casts[i].name_en}',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],

            ),
            margin: EdgeInsets.only(right: 10.0),
          );
        },
        itemCount: casts.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}