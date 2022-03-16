import 'package:flutter/services.dart';

String _mapStylePath = 'assets/json/mapStyle.json';

Future<String> renderMapStyle() async {
  return await rootBundle.loadString(_mapStylePath);
}
