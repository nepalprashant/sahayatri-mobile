import 'package:flutter/cupertino.dart';
import 'package:sahayatri/services/dio_services.dart';

class ForgotPassword extends ChangeNotifier {
  bool _isConnectionError = false;

  bool get isConnectionError => _isConnectionError;

  void forgotPassword({required Map email}) async {
    _isConnectionError = false;

    try {
      await dio().post('/forgot/password', data: email); //forwarding email
    } catch (e) {
      this._isConnectionError = true;
      notifyListeners();
    }
  }
}
