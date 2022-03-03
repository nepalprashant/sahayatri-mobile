import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/PODO_Classes/driver_details.dart';
import 'package:sahayatri/services/dio_services.dart';

class AvailableDrivers extends ChangeNotifier {
  late DriverDetails _driver;

  DriverDetails get driver => _driver;

  void availableDrivers() async {
    print('available drivers');
    String token = accessToken;
    print(token);
    try {
      Dio.Response response = await dio().get('/request/ride',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token'
          })); //fetching information
      print(response.data);
      response.data.forEach((data) => print(data['name']));
      print(response.data[0]['driver']['license_no']);
      // _driver =
      //     DriverDetails.fromJson(response.data); //storing driver information
      // print(_driver);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
