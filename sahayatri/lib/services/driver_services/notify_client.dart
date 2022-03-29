import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/dio_services.dart';

class NotifyClient extends ChangeNotifier {
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  void notifyClient({required int clientId}) async {
    _isConnected = true;
    Map details = {'client_id': clientId};

    try {
      await dio().post('/notify/client',
          data: details,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //forwarding information
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }
}
