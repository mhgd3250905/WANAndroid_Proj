import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';
import 'package:flutter/material.dart';
import 'package:douban_movies/WanAndroid/sp_utils.dart';
import 'dart:convert' show json;


 class ArticleSaveManager{
   static final String KEY_FAVORITE="key_favorite";
   static final String KEY_HISTORY="key_history";

   static Future<List<Data>> getSaveList(String key) async{
     List<Data> dataList=[];
     String dataListStr=await SpUtils.getString(key, "");
     if(dataListStr==null||dataListStr.isEmpty){
       return dataList;
     }
     List<String> itemStrList=dataListStr.split("-");
     if(itemStrList==null){
       return dataList;
     }
     for(int i=0;i<itemStrList.length;i++){
       dataList.add(Data.fromJson(itemStrList[i]));
     }
     return dataList;
   }

   static save(String key,Data data) async{
     String dataListStr=await SpUtils.getString(key, "");
     if(dataListStr==null||dataListStr.isEmpty){
       String dataStr=json.encode(data);
       SpUtils.save(key, dataStr);
     }else{
       StringBuffer sb=new StringBuffer();
       String dataStr=json.encode(data);
       sb.write(dataStr);
       sb.write("-");
       sb.write(dataListStr);
       print(sb.toString());
       SpUtils.save(key, sb.toString());
     }

   }
}