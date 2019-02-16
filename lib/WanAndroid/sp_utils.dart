import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
   * 存储数据
   */
class SpUtils {
  static final String KEY_ACCOUNT="key_account";


  static Future save(String key, Object value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value is String) {
      preferences.setString(key, value);
    } else if (value is int) {
      preferences.setInt(key, value);
    } else if (value is bool) {
      preferences.setBool(key, value);
    } else if (value is double) {
      preferences.setDouble(key, value);
    } else if (value is List<String>) {
      preferences.setStringList(key, value);
    }
  }

  static Future get(String key, Object defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (defaultValue is String) {
      defaultValue = preferences.getString(key);
    } else if (defaultValue is int) {
      defaultValue = preferences.getInt(key);
    } else if (defaultValue is bool) {
      defaultValue = preferences.getBool(key);
    } else if (defaultValue is double) {
      defaultValue = preferences.getDouble(key);
    } else if (defaultValue is List<String>) {
      defaultValue = preferences.getStringList(key);
    }
    return defaultValue;
  }

  static Future<String > getString(String key, String defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    defaultValue = preferences.getString(key);
    return defaultValue;
  }

  static Future getInt(String key, Object defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    defaultValue = preferences.getInt(key);
    return defaultValue;
  }

  static Future getBool(String key, Object defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    defaultValue = preferences.getBool(key);
    return defaultValue;
  }

  static Future getDouoble(String key, Object defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    defaultValue = preferences.getDouble(key);
    return defaultValue;
  }

  static Future getStringList(String key, Object defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    defaultValue = preferences.getStringList(key);
    return defaultValue;
  }

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
}
