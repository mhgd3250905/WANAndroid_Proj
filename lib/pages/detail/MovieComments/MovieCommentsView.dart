import 'package:flutter/material.dart';
import 'package:douban_movies/pages/views/ClipImageView.dart';
import 'package:douban_movies/data/bean_move_detail.dart';
import 'package:douban_movies/pages/views/StartsView.dart';

class MovieCommentsView extends StatelessWidget {
  final MovieDetail _detail;

  MovieCommentsView(this._detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: new Column(
        children:
          getCommentsList(_detail),
      ),
    );
  }

  getCommentsList(MovieDetail detail) {
    if (detail == null) {
      return [];
    }
    List<Widget> views = [];
    views.add(new Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10.0,top: 10.0,bottom: 20.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '短评',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    ));
    for (var i = 0; i < detail.popular_comments.length; i++) {
      print(detail.popular_comments[i]);
      views.add(new CommentItemView(detail.popular_comments[i],
          (i == (detail.popular_comments.length - 1))));
    }
    return views;
  }

}

class CommentItemView extends StatelessWidget {
  final popular_comment comment;
  final bool isLast;

  CommentItemView(this.comment, this.isLast);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            child: new Row(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  width: 30.0,
                  child: ClipImageView(
                      comment.author.avatar, BorderRadius.circular(15.0)),
                ),
                new Container(width: 10.0,),
                new Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: new Text(
                              comment.author.name,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: new Text(
                              comment.created_at,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            child: new Text(
              comment.content,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Icon(Icons.thumb_up, color: Colors.grey[300], size: 15.0,),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 5.0),
                    child: new Text(
                      '${comment.getUserfulCountDesc()}k',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          getDivider(isLast),
        ],
      ),
    );
  }

  getDivider(bool isLast) {
    if (!isLast) {
      return Container(
        margin: EdgeInsets.only(top: 20.0),
        child: new Divider(color: Colors.white,),
      );
    } else {
      return new Container();
    }
  }

}