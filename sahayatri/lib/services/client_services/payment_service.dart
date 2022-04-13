import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/dio_services.dart';

class PaymentService extends ChangeNotifier {
  bool _initiatePayment = false;
  late int _rideId;
  late int _amount;
  bool _isConnectionError = false;

  bool get isConnectionError => _isConnectionError;
  bool get initiatePayment => _initiatePayment;
  int get rideId => _rideId;
  int get amount => _amount;

  void proceedPayment({required int rideId, required double amount}) {
    _rideId = rideId;
    _amount = int.parse(amount.toStringAsFixed(0)); //double to string and string to int
    _initiatePayment = true;
    notifyListeners();
  }

  void paymentSuccess() {
    _initiatePayment = false;
    notifyListeners();
  }

  void recordOnlinePayment({required int rideId, required int amount}) async {
    _isConnectionError = false;
    Map paymentDetails = {
      'client_id': userId,
      'ride_id': rideId,
      'amount': amount
    };

    try {
      await dio().post('/online/payment',
          data: paymentDetails,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //forwarding information
    } catch (e) {
      this._isConnectionError = true;
      notifyListeners();
    }
  }

  void recordCashPayment({required int rideId, required int amount}) async {
    _isConnectionError = false;
    Map paymentDetails = {
      'client_id': userId,
      'ride_id': rideId,
      'amount': amount
    };

    try {
      await dio().post('/cash/payment',
          data: paymentDetails,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //forwarding information
    } catch (e) {
      this._isConnectionError = true;
      notifyListeners();
    }
  }
}
