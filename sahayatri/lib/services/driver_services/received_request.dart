import 'package:flutter/material.dart';
import 'package:sahayatri/PODO_Classes/request_details.dart';

class ReceivedRequest extends ChangeNotifier {
  late RequestDetails _request;
  bool _isReceived = false;

  RequestDetails get request => _request;
  bool get isReceived => _isReceived;

  void requestDetails(dynamic data) {
    _request = requestDetailsFromJson(data);
    this._isReceived = true;
    notifyListeners();
  }

  void changeStatus() {
    _isReceived = false;
    notifyListeners();
  }
}
