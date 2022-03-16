import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<String?> storedToken() async {
  String? token = await storage.read(key: 'access_token');
  return token;
}
