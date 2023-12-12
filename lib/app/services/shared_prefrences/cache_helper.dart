// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic setData({
    required SharedKey key,
    required dynamic value,
  }) async {
    if (value is int) {
      return await sharedPreferences.setInt(key.name, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key.name, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key.name, value);
    }
  }

  static dynamic getData({
    required SharedKey key,
  }) {
    return sharedPreferences.get(key.name);
  }

  static dynamic removeData({required SharedKey key}) {
    return sharedPreferences.remove(
      key.name,
    );
  }
}

enum SharedKey {
  Language,
  token,
  id,
}
