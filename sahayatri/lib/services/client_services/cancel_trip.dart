import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/dio_services.dart';

class CancleTrip extends ChangeNotifier {
  bool _isCancelled = false;
  bool _isConnected = true;

  bool get isCancelled => _isCancelled;
  bool get isConnected => _isConnected;

  void cancleTrip({required int driverId, required int rideId}) async {
    initialValues();
    //required information to be sent from POST method
    Map details = {
      'client_id': userId,
      'driver_id': driverId,
      'ride_id': rideId,
    };

    try {
      await dio().post('/cancel/trip',
          data: details,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //forwarding information
      _isCancelled = true;
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }

  void initialValues() {
    this._isCancelled = false;
    this._isConnected = true;
  }
}
