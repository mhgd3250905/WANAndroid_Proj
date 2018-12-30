import 'package:flutter/material.dart';
import 'package:douban_movies/data/bean_move_detail.dart';
import 'package:douban_movies/pages/views/ClipImageView.dart';
import 'package:douban_movies/pages/views/StartsView.dart';

class MoviePopularCommentsView extends StatelessWidget {
  final MovieDetail _detail;

  MoviePopularCommentsView(this._detail);

  @override
  Widget build(BuildContext context) {
    return _detail.popular_comments != null ?
    new Container(
      child: Column(
        children: <Widget>[
          new CommentItemView(_detail.popular_comments[0]),
        ],
      ),
    ) : new Container();
  }

}

class CommentItemView extends StatelessWidget {
  final popular_comment _comment;

  CommentItemView(this._comment);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Column(
        children: <Widget>[
          new CommentItemTopView(_comment),
          new Container(
            child: Text(
              '${_comment.content}',
            ),
          ),
//          new CommentItemBottomView(_comments),
        ],
      ),
    );
  }
}

class CommentItemTopView extends StatelessWidget {
  final popular_comment _comment;

  CommentItemTopView(this._comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: <Widget>[
          new ClipImageView(
            _comment.author.avatar,
            BorderRadius.circular(4.0),
          ),
          new Expanded(
              child: Container(
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Container(
                          child: new Text('${_comment.author.name}'),
                        ),
                        new Expanded(
                          child: new Container(
                            child: new StarItem(
                                int.parse(_comment.rating.stars==null?50:_comment.rating.stars), 15.0,
                                Colors.orange[300], true),
                          ),
                        ),
                      ],
                    ),
                    new Container(
                      child: Text('${_comment.created_at}'),
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}