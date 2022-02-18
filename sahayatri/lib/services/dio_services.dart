import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  //for android base application only while running from emulator
  //10.0.2.2:8000
  dio.options.baseUrl = "http://192.168.254.57:80/api";

  dio.options.headers['accept'] = 'application/json';

  return dio;
}
