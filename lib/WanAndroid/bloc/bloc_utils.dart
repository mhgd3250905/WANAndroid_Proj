import 'package:flutter/material.dart';
import 'dart:async';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  @override
  _BlocProviderState createState() => new _BlocProviderState();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState extends State<BlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }
}

class IncrementBloc implements BlocBase {
  int _counter;

  StreamController<int> _counterController = StreamController<int>.broadcast();

  StreamSink<int> get _inAdd => _counterController.sink;

  Stream<int> get outCounter => _counterController.stream;

  StreamController _actionControll = StreamController.broadcast();

  StreamSink get incrementCounter => _actionControll.sink;

  IncrementBloc() {
    _counter = 0;
    _actionControll.stream.listen(_handleLogic);
  }

  @override
  void dispose() {
    _actionControll.close();
    _counterController.close();
  }

  void _handleLogic(data) {
    _counter += 1;
    _inAdd.add(_counter);
  }
}