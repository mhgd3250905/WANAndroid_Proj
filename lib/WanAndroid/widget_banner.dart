import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_banner_bean.dart';
import 'package:douban_movies/WanAndroid/config.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:douban_movies/WanAndroid/navigator_router_utils.dart';
import 'package:douban_movies/WanAndroid/article_page.dart';
import 'package:douban_movies/WanAndroid/web_page.dart';


class BannerWidget extends StatefulWidget{
  @override
  _BannerWidgetState createState() =>_BannerWidgetState();

}

class _BannerWidgetState extends State<BannerWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildFutureBuilder();
  }

  FutureBuilder<BannerListBean> buildFutureBuilder() {
    return new FutureBuilder<BannerListBean>(
      builder: (context, AsyncSnapshot<BannerListBean> async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }

        if (async.connectionState == ConnectionState.done) {
          debugPrint('done');
          if (async.hasError) {
            return new Center(
              child: new Text('Error:code '),
            );
          } else if (async.hasData) {
            BannerListBean bean = async.data;
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new FadeInImage.memoryNetwork(
                  fit: BoxFit.fitWidth,
                  placeholder: kTransparentImage,
                  image: bean.data[index].imagePath,
                );
              },
              itemCount: bean.data.length,
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.black54,
                    activeColor: Colors.white,
                  )),
              control: new SwiperControl(),
              scrollDirection: Axis.horizontal,
              autoplay: true,
              onTap: (index){
                NavigatorRouterUtils.pushToPage(
                    context,
                    new WebPage(
                      title: bean.data[index].getName(),
                      url: bean.data[index].url,
                    ));
              },
            );
          }
        }
      },
      future: getData(),
    );
  }


  Future<BannerListBean> getData() async {
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(URL_BANNER_LIST);
    BannerListBean bean = BannerListBean.fromJson(response.data);
    return bean;
  }

}