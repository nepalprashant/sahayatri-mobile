import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Helper_Classes/access_token.dart';
import 'package:sahayatri/services/auth.dart';

class PreviousLogin extends ChangeNotifier {
  bool _previousLogged = false;
  String? _token;

  bool get previousLogin => _previousLogged;

  void getToken() async {
    //getting the stored token from previous login session
    _token = await storedToken();

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
