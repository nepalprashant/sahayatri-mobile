import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Client/client_main_page.dart';
import 'package:sahayatri/Driver/driver_main_page.dart';
import 'package:sahayatri/services/dio_services.dart';

class Auth extends ChangeNotifier {
  bool _isLogged = false;
  bool _isClient = false;
  bool _isDriver = false;

  bool get authenticated => _isLogged;
  bool get isClient => _isClient;
  bool get isDriver => _isDriver;

  void login({required Map credentials}) async {
    try {
      Dio.Response response =
          await dio().post('/sanctum/token', data: credentials);

      print(response.data['type']);
      determineUserType(response.data['type']);

      _isLogged = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void determineUserType(String type) {
    if (type == 'client') {
      _isClient = true;
      ClientMainPage();
    } else if (type == 'driver') {
      _isDriver = true;
      DriverMainPage();
    }
  }

  void clientLogout() {
    _isClient = false;
    _isLogged = false;
    notifyListeners();
  }

  void driverLogout() {
    _isDriver = false;
    _isLogged = false;
    notifyListeners();
  }

  void signup({required Map userDetails}) async {
    Dio.Response response = await dio().post('/register', data: userDetails);

    print(response);
  }
}
