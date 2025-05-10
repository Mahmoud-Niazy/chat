import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiServices {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? '',
        contentType: 'application/json',
        connectTimeout: const Duration(seconds: 15),
      ),
    );
  }

  Future<dynamic> getData({
    required String path,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      "Authorization" : "Bearer $token",
    };
    var response = await dio.get(
      path,
      queryParameters: query,
    );
    return response.data;
  }

  Future<Response> postData({
    required String path,
    required dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      "Authorization" : "Bearer $token",
    };
    return await dio.post(
      path,
      data: data,
    );
  }

  Future<Response> patchData({
    required String path,
    required dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      "Authorization" : "Bearer $token",
    };
    return await dio.patch(
      path,
      data: data,
    );
  }

  Future<Response> putData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    return await dio.put(
      path,
      data: data,
    );
  }

  Future<Response> deleteData({
    required String path,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      "Authorization" : "Bearer $token",
    };
    return await dio.delete(
      path,
      data: data,
    );
  }
}