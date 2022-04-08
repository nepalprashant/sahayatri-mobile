import 'dart:convert';
import 'package:flutter/services.dart';

const String _configFilePath = 'assets/json/config.json';

Future<Map<String, dynamic>> renderConfigFile() async {
  //loading the data from the JSON file inside assets folder
  String json = await rootBundle.loadString(_configFilePath);
  return jsonDecode(json) as Map<String, dynamic>;
}
