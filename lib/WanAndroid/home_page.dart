import 'package:douban_movies/WanAndroid/article_list_content.dart';
import 'package:douban_movies/WanAndroid/article_page.dart';
import 'package:douban_movies/WanAndroid/icon_font_utils.dart';
import 'package:douban_movies/WanAndroid/knowledge_tree_page.dart';
import 'package:douban_movies/WanAndroid/person_page.dart';
import 'package:douban_movies/WanAndroid/popular_page.dart';
import 'package:douban_movies/WanAndroid/project_page.dart';
import 'package:douban_movies/WanAndroid/search_page_2.dart';
import 'package:flutter/material.dart';


class WanAndroidMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '玩安卓',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new WanAndroidHomePage(),
    );
  }
}

class WanAndroidHomePage extends StatefulWidget {
  @override
  _WanAndroidHomePageState createState() => _WanAndroidHomePageState();
}

class _WanAndroidHomePageState extends State<WanAndroidHomePage>
    with AutomaticKeepAliveClientMixin {
  final _pages = [
    ArticleListPage(
      type: ArticleType.HOME_ARTICLE,
    ),
    PopularContentView(),
    KnowledgeTreePage(),
    ProjectTreePage(),
    PersonPage(),
  ];
  final _controller = PageController(initialPage: 0);
  int _selectedIndex = 0;

  void onItemTap(int index) {
    debugPrint('$index');
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text('玩安卓'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {
              showSearch(context: context, delegate: searchBarDelegate());
            },
          ),
        ],
      ),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: _pages,
        onPageChanged: (index) {
          if (_selectedIndex != index) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: IconFontUtils.getIcon(0xe639),
              title: Text(
                '文章',
                style: TextStyle(
                  height: 1.1,
                ),
              ),
              backgroundColor: Colors.blue),
          new BottomNavigationBarItem(
            icon: IconFontUtils.getIcon(0xe600),
            title: Text(
              '导航',
              style: TextStyle(
                height: 1.1,
              ),
            ),
            backgroundColor: Colors.orange,
          ),
          new BottomNavigationBarItem(
            icon: IconFontUtils.getIcon(0xe61f),
            title: Text(
              '知识树',
              style: TextStyle(
                height: 1.1,
              ),
            ),
            backgroundColor: Colors.green,
          ),
          new BottomNavigationBarItem(
            icon: IconFontUtils.getIcon(0xe64f),
            title: Text(
              '项目',
              style: TextStyle(
                height: 1.1,
              ),
            ),
            backgroundColor: Colors.yellow,
          ),
          new BottomNavigationBarItem(
            icon: IconFontUtils.getIcon(0xe612),
            title: Text(
              '个人',
              style: TextStyle(
                height: 1.1,
              ),
            ),
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: onItemTap,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
