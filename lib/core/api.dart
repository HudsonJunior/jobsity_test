import 'package:dio/dio.dart';

abstract class RestApi<T> {
  Future<T> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}

class RestApiImpl implements RestApi<Response> {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.tvmaze.com/'));

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(path, queryParameters: queryParameters);
  }
}
