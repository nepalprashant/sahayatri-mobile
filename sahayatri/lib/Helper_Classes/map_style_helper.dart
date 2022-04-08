import 'package:flutter/services.dart';

String _mapStylePath = 'assets/json/mapStyle.json';

Future<String> renderMapStyle() async {
  //loading map style from the JSON file
  return await rootBundle.loadString(_mapStylePath);
}
