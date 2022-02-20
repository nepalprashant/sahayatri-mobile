import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/services/dio_services.dart';

class RegisterUser extends ChangeNotifier {
  bool _registered = false;
  int? errorStatus;

  bool get registered => _registered;
  void signup({required Map userDetails}) async {
    try {
      await dio().post('/register', data: userDetails);
      _registered = true;
      print('success');
      notifyListeners();
    } on Dio.DioError catch (e) {
      _registered = false;
      print('error');
      errorStatus = e.response?.statusCode;
      notifyListeners();
    }
  }
}
