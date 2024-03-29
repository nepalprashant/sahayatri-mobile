import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Events/client_events/client_channel_subscriptions.dart';
import 'package:sahayatri/Events/driver_events/driver_channel_subscriptions.dart';

import 'package:sahayatri/PODO_Classes/user_details.dart';
import 'package:sahayatri/services/dio_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth extends ChangeNotifier {
  late User _user;
  bool _isLogged = false;
  bool _isClient = false;
  bool _isDriver = false;
  bool _fromLogout = false;
  late String _personalAccessToken;
  final storage = new FlutterSecureStorage();

  bool get authenticated => _isLogged;
  bool get isClient => _isClient;
  bool get isDriver => _isDriver;
  bool get fromLogout => _fromLogout;
  User get user => _user;

  void login({required Map credentials}) async {
    _fromLogout = false;
    try {
      Dio.Response response = await dio().post('/sanctum/token',
          data: credentials); //getting personal access token

      _personalAccessToken = response.data['token'];

      accessUser(_personalAccessToken);

      storeToken(_personalAccessToken);
    } catch (e) {
      print(e);
    }
  }

  void accessUser(String token) async {
    try {
      Dio.Response response = await dio().get('/user',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token'
          })); //fetching user information
      _user =
          User.fromJson(response.data); //storing user information of type User

      determineUserType(response.data['type'], token);
      _isLogged = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //to classify the user type based on the response
  void determineUserType(String type, String token) {
    userId = _user.id;
    accessToken = token;
    if (type == 'client') {
      enableClientChannels(id: userId, token: token);
      _isClient = true;
    } else if (type == 'driver') {
      enableDriverChannels(id: userId, token: token);
      _isDriver = true;
    }
  }

  void clientLogout() async {
    _isClient = false;
    _isLogged = false;
    _fromLogout = true;
    storage.deleteAll();
    disableClientChannels(id: _user.id);
    try {
      await dio().get('/user/revoke',
          options: Dio.Options(
              headers: {'Authorization': 'Bearer $_personalAccessToken'}));
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void driverLogout() async {
    _isDriver = false;
    _isLogged = false;
    _fromLogout = true;
    storage.deleteAll();
    disableDriverChannels(id: _user.id);
    try {
      await dio().get('/user/revoke',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $_personalAccessToken'
          })); //deleting personal access token after logging out
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  //storing token locally to prevent signing in
  void storeToken(String token) {
    storage.write(key: 'access_token', value: token);
  }
}
