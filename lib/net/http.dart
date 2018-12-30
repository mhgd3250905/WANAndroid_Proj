import 'package:dio/dio.dart';

class HttpUtils {
  static String URL_GET_MOVIE_LIST_IN_THEATERS = 'https://api.douban.com/v2/movie/in_theaters';
  static String URL_GET_MOVIE_LIST_COMING_SOON = 'https://api.douban.com/v2/movie/coming_soon';
  static String URL_GET_MOVIE_LIST_TOP_250 = 'https://api.douban.com/v2/movie/top250';
  static String URL_GET_MOVIE_LIST_WEEKLY = 'https://api.douban.com/v2/movie/weekly';
  static String URL_GET_MOVIE_LIST_US_BOX = 'https://api.douban.com/v2/movie/us_box';
  static String URL_GET_MOVIE_LIST_NEW_MOVIES = 'https://api.douban.com/v2/movie/new_movies';
  static String URL_GET_MOVIE_DETAIL = 'http://api.douban.com/v2/movie/subject/';
  static String URL_API_KEY='0b2bdeda43b5688921839c8ecb20399b';
  static String URL_UDID='dddddddddddddddddddddd';

  static get(String url, {Map map}) async {
    Dio dio = new Dio();
    Response response = await dio.get(url,data: map);
    return response.data;
  }
}