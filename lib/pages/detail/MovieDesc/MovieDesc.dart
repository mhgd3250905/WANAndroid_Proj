import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:douban_movies/data/bean_move_detail.dart';

class MovieDescView extends StatelessWidget {

  final MovieDetail detail;

  MovieDescView(this.detail);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            child: new Text('简介',
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            child: new ExpansionText(detail.summary.substring(0, 40),
                detail.summary, false),
          ),
        ],
      ),
    );
  }
}


class ExpansionText extends StatefulWidget {

  final String title;
  final String body;
  final bool expand;

  ExpansionText(this.title, this.body, this.expand);

  @override
  _ExpansionTextState createState() =>
      _ExpansionTextState(this.title, this.body, this.expand);

}

class _ExpansionTextState extends State<ExpansionText> {

  String _title;
  String _body;
  bool _expand;

  _ExpansionTextState(String title, String body, bool expand) {
    this._title = title;
    this._body = body;
    this._expand = expand;
  }


  expandText() {
    if (_expand) {
      _expand = false;
    } else {
      _expand = true;
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {


    return new Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: new Text.rich(new TextSpan(
        children: [
          new TextSpan(
            text: _expand ? _body : _title,
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                expandText();
              },
          ),
          getExpandText(_expand),
        ],
      ),),
    );
  }

  getExpandText(bool expand) {
    return expand ? new TextSpan() : new TextSpan(
      text: '展开',
      recognizer: new TapGestureRecognizer()
        ..onTap = () {
          expandText();
        },
      style: new TextStyle(
        decoration: TextDecoration.underline,
        color: Colors.lightBlue,
      ),
    );
  }
}