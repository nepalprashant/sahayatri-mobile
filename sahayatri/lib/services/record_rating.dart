import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/services/dio_services.dart';

class RecordRating extends ChangeNotifier {
  bool _isConnectionError = false;

  bool get isConnectionError => _isConnectionError;

  void recordRating({required int id, required double rate}) async {
    _isConnectionError = false;
    Map ratingDetails = {
      'user_id': id,
      'rate': rate,
    };

    try {
      await dio().post('/rate/user',
          data: ratingDetails,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $accessToken'
          })); //forwarding information
    } catch (e) {
      this._isConnectionError = true;
      notifyListeners();
    }
  }
}
