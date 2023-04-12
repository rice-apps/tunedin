import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '', // TO:DO change this to an actual base url
    ),
  );

  Dio get http => _dio;
}
