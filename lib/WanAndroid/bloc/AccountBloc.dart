import 'dart:async';

import 'package:douban_movies/WanAndroid/sp_utils.dart';

import 'bloc_utils.dart';

class AccountBloc implements BlocBase {
  String _account;

  String get getAccount => _account;

  StreamController<String> _accountController =
      StreamController<String>.broadcast();

  StreamSink<String> get _accountSink => _accountController.sink;

  Stream<String> get accountStream => _accountController.stream;

  StreamController _actionControll = StreamController.broadcast();

  StreamSink get accountSaveSink => _actionControll.sink;

  AccountBloc() {
    _account = "";
    _actionControll.stream.listen(_handleLogic);
    initAccount();
  }

  @override
  void dispose() {
    _accountController.close();
    _actionControll.close();
  }

  void _handleLogic(data) {
    _account = data;
    _accountSink.add(_account);
    SpUtils.save(SpUtils.KEY_ACCOUNT, data);
  }

  void initAccount() async {
    _account = await SpUtils.get(SpUtils.KEY_ACCOUNT, "");
    accountSaveSink.add(_account);
  }
}
