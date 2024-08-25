import 'package:dio/dio.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000";
  final Dio dio = Dio();

  Future<Response> get(String url) async {
    try {
      return await dio.get(baseUrl + url);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String url, Map<String, dynamic> data) async {
    return await dio.post(baseUrl + url, data: data);
  }

  Future<Response> put(String url, Map<String, dynamic> data) async {
    return await dio.put(baseUrl + url, data: data);
  }

  Future<Response> delete(String url) async {
    return await dio.delete(baseUrl + url);
  }
}
