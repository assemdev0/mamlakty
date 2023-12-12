import 'package:dio/dio.dart';

import '../../constant/api_constant.dart';

class DioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: ApiConstant.baseUrl,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(path, queryParameters: queryParameters);
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json'
    };
    return await dio.post(path, data: data);
  }

  static Future<Response> delData({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? token,
    dynamic data,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.delete(
      path,
    );
  }

  static Future<Response> updateData({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json'
    };
    return await dio.put(
      path,
      data: data,
    );
  }
}
