import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/dio_services.dart';

class RideStatus extends ChangeNotifier {
  bool _isStarted = false;
  bool _isCompleted = false;
  bool _isConnectionError = false;
  late int _rideId;

  bool get isStarted => _isStarted;
  bool get isCompleted => _isCompleted;
  int get rideId => _rideId;
  bool get isConnectionError => _isConnectionError;

  void started(int id) {
    _isStarted = true;
    _rideId = id;
    notifyListeners();
  }

  void completed() {
    _isCompleted = true;
    notifyListeners();
  }

  void rideOnComplete({required int clientId})async{
    this._isConnectionError = false;
    Map details = {
      'client_id': clientId,
      'driver_id': userId,
      'ride_id': this._rideId,
    };
    try {
      await dio().post('/ride/completed',
          data: details,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //forwarding information
      completed();
      notifyListeners();
    } catch (e) {
      this._isConnectionError = true;
      notifyListeners();
    }
  }
}
