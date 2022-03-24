import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/PODO_Classes/driver/driver_pending_trips.dart';
import 'package:sahayatri/services/dio_services.dart';

class DriverPendingRides extends ChangeNotifier {
  late List<DriverPendingTrips> _pendingTrips;
  bool _anyTrips = false;
  bool _isUptoDate = false;
  bool _isConnected = true;

  List<DriverPendingTrips> get driverTrips => _pendingTrips;
  bool get anyTrips => _anyTrips;
  bool get isUptoDate => _isUptoDate;
  bool get isConnected => _isConnected;


  void pendingTrips() async {
    initialState();
    try {
      Dio.Response response = await dio().get('/pending/requests',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //fetching information

      //storing fetched pending information
      _pendingTrips = driverPendingTripsFromJson(jsonEncode(response.data));

      //checking if no any pending trips
      (_pendingTrips.length > 0)
          ? _anyTrips = true
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

  void initialState(){
    _isConnected = true;
    _anyTrips = false;
    _isUptoDate = false;
    notifyListeners();
  }
}
