import 'package:flutter/material.dart';
import 'package:sahayatri/PODO_Classes/client/request_details.dart';

class ReceivedRequest extends ChangeNotifier {
  late RequestDetails _request;
  bool _isReceived = false;

  RequestDetails get request => _request;
  bool get isReceived => _isReceived;

  //storing the displaying the received request dynamically in the widget
  void requestDetails(dynamic data) {
    this._isReceived = false;

    _request = requestDetailsFromJson(data);

    this._isReceived = true;
    
    Future.delayed(const Duration(minutes: 5), () {
      this._isReceived = false;
      notifyListeners();
    });

    notifyListeners();
  }

  void changeStatus() {
    _isReceived = false;
    notifyListeners();
  }
}
