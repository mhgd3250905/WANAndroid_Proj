import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_banner_bean.dart';
import 'package:douban_movies/WanAndroid/config.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:douban_movies/WanAndroid/navigator_router_utils.dart';
import 'package:douban_movies/WanAndroid/web_page.dart';


BannerListBean bannerListBean;

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    //如果banner已经加载过，那么刷新的时候轮播图就不再进行下一次刷新了
    if (bannerListBean != null) {
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              elevation: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: new FadeInImage.memoryNetwork(
                  fit: BoxFit.fill,
                  placeholder: kTransparentImage,
                  image: bannerListBean.data[index].imagePath,
                ),
              ),
            ),
          );
        },
        itemCount: bannerListBean.data.length,
        viewportFraction: 0.85,
        scale: 0.95,
        pagination: null,
        control: null,
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) {
          NavigatorRouterUtils.pushToPage(
              context,
              new WebPage(
                title: bannerListBean.data[index].getName(),
                url: bannerListBean.data[index].url,
              ));
        },
      );
    } else {
      return buildFutureBuilder();
    }
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
            bannerListBean = async.data;
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    elevation: 4.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: new FadeInImage.memoryNetwork(
                        fit: BoxFit.fill,
                        placeholder: kTransparentImage,
                        image: bannerListBean.data[index].imagePath,
                      ),
                    ),
                  ),
                );
              },
              itemCount: bannerListBean.data.length,
              viewportFraction: 0.85,
              scale: 0.95,
              pagination: null,
              control: null,
              scrollDirection: Axis.horizontal,
              autoplay: true,
              onTap: (index) {
                NavigatorRouterUtils.pushToPage(
                    context,
                    new WebPage(
                      title: bannerListBean.data[index].getName(),
                      url: bannerListBean.data[index].url,
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