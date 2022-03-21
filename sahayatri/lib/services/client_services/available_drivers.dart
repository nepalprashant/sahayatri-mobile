import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/PODO_Classes/driver/driver_details.dart';
import 'package:sahayatri/services/dio_services.dart';

class AvailableDrivers extends ChangeNotifier {
  late List<DriverDetails> _driver;
  bool _isAvailable = false;
  bool _displayError = false;

  List<DriverDetails> get drivers => _driver;
  bool get isAvailable => _isAvailable;
  bool get displayError => _displayError;

  //getting the details of the available drivers
  void availableDrivers() async {
    initialValues();
    try {
      Dio.Response response = await dio().get('/request/ride',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //fetching information

      _driver = driverDetailsFromJson(jsonEncode(response.data));
      (_driver.length > 0)
          ? _isAvailable = true
          : Future.delayed(const Duration(seconds: 3), () {
              _isAvailable = false;
              _displayError = true;
              notifyListeners();
            });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void initialValues() {
    _isAvailable = false;
    _displayError = false;
  }
}
