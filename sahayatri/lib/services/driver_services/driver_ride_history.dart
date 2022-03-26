import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/PODO_Classes/ride_history.dart';
import 'package:sahayatri/services/dio_services.dart';

class DriverRideHistory extends ChangeNotifier {
  late List<RideHistory> _history;
  bool _anyRides = false;
  bool _isConnected = true;
  bool _isUptoDate = false;

  bool get anyRides => _anyRides;
  bool get isConnected => _isConnected;
  bool get isUptoDate => _isUptoDate;
  List<RideHistory> get rideHistory => _history;

  void getRideHistory() async {
    initialValues();
    try {
      Dio.Response response = await dio().get('/driver/history',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //fetching information

      //storing fetched pending information
      _history = rideHistoryFromJson(jsonEncode(response.data));

      //checking if no any pending trips
      (_history.length > 0)
          ? _anyRides = true
          : Future.delayed(const Duration(seconds: 3), () {
              _isUptoDate = true;
              notifyListeners();
            });
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }

  void initialValues() {
    this._anyRides = false;
    this._isConnected = true;
    this._isUptoDate = false;
  }
}
