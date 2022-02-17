import 'package:flutter/cupertino.dart';
import 'dart:io';

class Connectivity extends ChangeNotifier {
  bool _internetConnection = true;

  bool get internetConnection => _internetConnection;

  void connectionStatus() async {
    _internetConnection = await isConnected();
    notifyListeners();
  }

  Future<bool> isConnected() async {
    try {
      final response = await InternetAddress.lookup('example.com');
      if (response[0].rawAddress.isNotEmpty && response.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
