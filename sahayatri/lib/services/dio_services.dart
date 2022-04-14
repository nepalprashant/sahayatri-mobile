import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  //for android base application only while running from emulator
  //10.0.2.2:8000
  dio.options.baseUrl = "http://sahayatri-env.eba-86dga554.ap-south-1.elasticbeanstalk.com/api";

  dio.options.headers['accept'] = 'application/json';

  return dio;
}
