import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  //for android base application only while running from emulator
  dio.options.baseUrl = "http://10.0.2.2:8000/api";

  dio.options.headers['accept'] = 'application/json';

  dio.options.connectTimeout = 6000;

  dio.options.receiveTimeout = 1000;

  return dio;
}
