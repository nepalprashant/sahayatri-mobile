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
    initState();
    try {
      await dio().get('/online',
          options:
              Dio.Options(headers: {'Authorization': 'Bearer $accessToken'}));
      this._isOnline = true;
      notifyListeners();
    } catch (e) {}
  }

  void offline() async {
    initState();
    try {
      await dio().get('/offline',
          options:
              Dio.Options(headers: {'Authorization': 'Bearer $accessToken'}));
      this._isOffline = true;
      notifyListeners();
    } catch (e) {}
  }

  void initState(){
    this._isOnline = false;
    this._isOffline = false;
  }
}
