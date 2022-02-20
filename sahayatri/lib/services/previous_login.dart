import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/services/auth.dart';

class PreviousLogin extends ChangeNotifier {
  final storage = FlutterSecureStorage();
  bool _previousLogged = false;
  String? _token;

  bool get previousLogin => _previousLogged;

  void getToken() async {
    _token = await storage.read(key: 'access_token');

    if (_token != null) {
      _previousLogged = true;
      notifyListeners();
    }
  }

  void accessUser(BuildContext context) {
    Provider.of<Auth>(
      context,
      listen: false,
    ).accessUser(_token!);
  }
}
