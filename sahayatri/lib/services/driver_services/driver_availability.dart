import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/dio_services.dart';

class ChangeAvailability extends ChangeNotifier {
  bool _isOnline = false;
  bool _isOffline = false;

  bool get isOnline => _isOnline;
  bool get isOffline => _isOffline;

  void online() async {
    try {
      Dio.Response response = await dio().get('/online',
          options:
              Dio.Options(headers: {'Authorization': 'Bearer $accessToken'}));
    } catch (e) {
      print(e);
    }
  }
}
