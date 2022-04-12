import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/services/dio_services.dart';

class RequestResponse extends ChangeNotifier {
  bool _isAccepted = false;
  bool _isRejected = false;
  bool _isConnected = true;

  bool get isAccepted => _isAccepted;
  bool get isRejected => _isRejected;
  bool get isConnected => _isConnected;

  //sending response to the backend when request is being accepted
  void acceptRequest(
      {required int clientId,
      required int rideId,
      required String name}) async {
    _isConnected = true;
    Map details = {
      'client_id': clientId,
      'ride_id': rideId,
      'driver_id': userId,
      'response': 'accepted',
    };
    try {
      await dio().post('/driver/response',
          data: details,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //forwarding information
      _isAccepted = true;
      NotificationHandler.displayNotificaiton(
          title: 'Ride Confirmed',
          body: 'Your ride has been scheduled with $name');
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }

  //sending response to the server when request has been rejected
  void rejectRequest({required int clientId, required int rideId}) async {
    _isConnected = true;
    Map details = {
      'client_id': clientId,
      'ride_id': rideId,
      'driver_id': userId,
      'response': 'rejected',
    };
    try {
      await dio().post('/driver/response',
          data: details,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //forwarding information
      this._isRejected = true;
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }

  void initialState() {
    this._isAccepted = false;
    this._isRejected = false;
  }
}
