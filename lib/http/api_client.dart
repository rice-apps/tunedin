import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          'https://tunedin-api.herokuapp.com', // TO:DO change this to an actual base url
    ),
  );

  Dio get http => _dio;
}
