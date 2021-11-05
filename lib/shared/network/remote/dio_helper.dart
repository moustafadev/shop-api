import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,
        String? token,
        String login = 'en',
      }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? ''
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    String? url,
    dynamic data,
    String? token,
    String login = 'en',
  }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.post(
      url!,
      data: data,
    );
  }

  static Future<Response> putData({
    String? url,
    dynamic data,
    String? token,
    String login = 'en',
  }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.put(
      url!,
      data: data,
    );
  }


}
