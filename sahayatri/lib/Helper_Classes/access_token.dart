import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sahayatri/Constants/constants.dart';

final storage = FlutterSecureStorage();

Future<String?> storedToken() async {
  String? token = await storage.read(key: 'access_token');
  if(token != null){
    accessToken = token;
  }
  return token;
}
