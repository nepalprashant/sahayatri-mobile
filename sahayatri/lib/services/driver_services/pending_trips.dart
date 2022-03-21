import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/dio_services.dart';

class PendingTrips extends ChangeNotifier {
  void pendingTrips() async {
    try {
      Dio.Response response = await dio().get('/pending/trips',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //fetching information

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
