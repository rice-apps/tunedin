import 'dart:io';

import 'package:dio/dio.dart';

import '../constants.dart';
import '../data/repositories/storage_repository.dart';

final String baseUrl = Platform.isAndroid ? backendURLAndroid : backendURL;

StorageRepository storage = StorageRepository();

Future<String?> get _token async {
  String? token = await storage.readSecureData(keyToken);
  return token;
}

class ApiClient {
  Future<Dio> getDio() async {
    final token = await _token;
    Map<String, dynamic> header = {
      'Authorization': 'Bearer $token',
    };

    final options = BaseOptions(baseUrl: baseUrl, headers: header);
    return Dio(options);
  }

  Future<Dio> get http async => await getDio();
}
