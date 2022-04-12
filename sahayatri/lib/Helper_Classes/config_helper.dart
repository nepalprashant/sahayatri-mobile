import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sahayatri/Constants/constants.dart';

const String _configFilePath = 'assets/json/config.json';

Future<Map<String, dynamic>> renderConfigFile() async {
  //loading the data from the JSON file inside assets folder
  String json = await rootBundle.loadString(_configFilePath);
  //fetching and storing API key for global use
  Map<String, dynamic> jsonData = jsonDecode(json) as Map<String, dynamic>;

  apiKey = jsonData['map_api'];

  return jsonData;
}
