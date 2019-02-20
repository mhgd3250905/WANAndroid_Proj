import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:douban_movies/WanAndroid/bloc/ApplicationBloc.dart';
import 'package:douban_movies/WanAndroid/bloc/bloc_utils.dart';
import 'WanAndroid/home_page.dart';

void main() {
  //设置debugPaintSizeEnabled为true来更直观的调试布局问题
  debugPaintSizeEnabled = false;
  return runApp(BlocProvider<ApplicationBloc>(
    child: Application(),
    bloc: ApplicationBloc(),
  ));
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    ApplicationBloc bloc=BlocProvider.of<ApplicationBloc>(context);

    return StreamBuilder<ThemeData>(
      initialData: bloc.getTheme,
      stream: bloc.themeStream,
      builder: (BuildContext context,AsyncSnapshot<ThemeData> snapshot){
        return WanAndroidMainPage(
          themeData: snapshot.data,
        );
      },
    );
  }
}


