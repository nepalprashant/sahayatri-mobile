
// import 'package:flutter/cupertino.dart';
// import 'dart:math' show cos, sqrt, asin;

// class CalculateDistance extends ChangeNotifier{

//   double _totalDiatance = 0.0;

//   double get totalDistance => _totalDiatance;

//   void calculateDistance({
//     required String initialLat,
//     required String initialLng,
//     required String destinationLat,
//     required String destinationLng,
//   }){

//     // var lat1 = 
//     // https://stackoverflow.com/a/54138876/11910277
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   void getPolylinePoints()
// }