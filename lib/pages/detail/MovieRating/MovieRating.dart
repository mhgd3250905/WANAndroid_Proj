import 'package:flutter/material.dart';
import 'package:douban_movies/data/bean_move_detail.dart';
import 'package:douban_movies/pages/views/StartsView.dart';

class MovieRatingView extends StatelessWidget {
  final MovieDetail detail;

  MovieRatingView(this.detail);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.grey[500],
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      width: double.infinity,
      height: 160.0,
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: new Text(
              '豆瓣评分',
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
            height: 10.0,
            width: double.infinity,
          ),
          new Container(
            height: 110.0,
            width: double.infinity,
            child: new RateStarsView(detail),
          ),
          new Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Divider(color: Colors.grey[300],),
          ),
          new Container(
            margin: EdgeInsets.only(right: 10.0),
            width: double.infinity,
            child: Text('${detail.getCollectPeopleCount()}k人看过  ${detail
                .getWishPeopleCount()}k人想看',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 12.0,
              ),
              textAlign: TextAlign.end,),
          ),
        ],
      ),
    );
  }
}

class RateStarsView extends StatelessWidget {
  final MovieDetail detail;

  RateStarsView(this.detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 3,
          child: new RateStarsLeftView(detail),
        ),
        new Expanded(
          flex: 7,
          child: new RateStarsRightView(detail),
        ),
      ],
    );
  }
}

///评分区域中间左边的部分
class RateStarsLeftView extends StatelessWidget {
  final MovieDetail detail;

  RateStarsLeftView(this.detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Expanded(
            child: new Container(
              child: new Text(
                '${detail.rating.average}',
                style: new TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              alignment: Alignment.bottomRight,
            )),
        new Row(
          children: <Widget>[
            new Expanded(child: new Container()),
            new Container(
              child: new StarItem(int.parse(detail.rating.stars), 15.0,
                  Colors.orange[300], true),
              padding: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.topRight,
            )
          ],
        )
      ],
    );
  }
}

///评分区域中间中部的部分
class RateStarsRightView extends StatelessWidget {
  final MovieDetail detail;

  RateStarsRightView(this.detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Expanded(child: new Container()),
        new Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(left: 5.0),
          child: new Column(
            children: <Widget>[
              new StarAndProgressItem(detail.rating, 5),
              new StarAndProgressItem(detail.rating, 4),
              new StarAndProgressItem(detail.rating, 3),
              new StarAndProgressItem(detail.rating, 2),
              new StarAndProgressItem(detail.rating, 1),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ),
        new Container(
          height: 20.0,
          width: double.infinity,
          margin: EdgeInsets.only(left: 145.0),
          alignment: Alignment.centerLeft,
          child: new Text('${detail.rating.details.getDetailTotal()}人评分',
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[300]
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

class StarAndProgressItem extends StatelessWidget {
  final rate _rate;
  final int _starIndex;

  StarAndProgressItem(this._rate, this._starIndex);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          width: 60.0,
          alignment: Alignment.centerRight,
          child: new Row(
            children: <Widget>[
              new Expanded(child: new Container()),
              new Container(
                alignment: Alignment.centerRight,
                child: new StarItem(
                    _starIndex * 10, 12.0, Colors.grey[300], false),
              )
            ],
          ),
        ),
        new Container(
          width: 150.0,
          child: new LinearProgressIndicator(
            value: _rate.details.getDetailIndexRate(_starIndex),
            backgroundColor: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}