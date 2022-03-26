import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/PODO_Classes/client/client_upcoming_trips.dart';
import 'package:sahayatri/services/dio_services.dart';

class UpcomingRides extends ChangeNotifier {
  late List<ClientUpcomingTrips> _upcomingTrips;
  bool _anyTrips = false;
  bool _isUptoDate = false;
  bool _isConnected = true;

  List<ClientUpcomingTrips> get upcomingTrips => _upcomingTrips;
  bool get anyTrips => _anyTrips;
  bool get isUptoDate => _isUptoDate;
  bool get isConnected => _isConnected;

  void getUpcomingTrips() async {
    initialState();
    try {
      Dio.Response response = await dio().get('/upcoming/trips',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //fetching information

      //storing fetched pending information
      _upcomingTrips = clientUpcomingTripsFromJson(jsonEncode(response.data));

      //checking if no any pending trips
      (_upcomingTrips.length > 0)
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

  void initialState() {
    _isConnected = true;
    _anyTrips = false;
    _isUptoDate = false;
    notifyListeners();
  }
}
