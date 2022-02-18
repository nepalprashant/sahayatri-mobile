import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/services/dio_services.dart';

class Auth extends ChangeNotifier {
  bool _isLogged = false;

  bool get authenticated => _isLogged;

  void login({required Map credentials}) async {
    try {
      Dio.Response response =
          await dio().post('/sanctum/token', data: credentials);

      print(response.data.toString());

      _isLogged = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void signup({required Map userDetails}) async {
    Dio.Response response = await dio().post('/register', data: userDetails);

    print(response);
  }

  void logout() {
    _isLogged = false;
    notifyListeners();
  }
}
