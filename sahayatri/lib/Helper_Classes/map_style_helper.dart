import 'package:flutter/services.dart';

String _mapStylePath = 'assets/json/mapStyle.json';

set setMapStylePath(String path) {
  _mapStylePath = path;
}

Future<String> renderMapStyle() async {
  return await rootBundle.loadString(_mapStylePath);
}
