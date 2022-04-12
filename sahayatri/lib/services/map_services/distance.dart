import 'package:flutter/cupertino.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sahayatri/Constants/constants.dart';

class CalculateDistance extends ChangeNotifier {
  PolylinePoints _polylinePoints = new PolylinePoints();

  //coordinates to join routes
  List<LatLng> _coordinates = [];

  double _totalDistance = 0.0;

  double get totalDistance => _totalDistance;

  void calculateDistance({
    required LatLng origin,
    required LatLng destination,
  }) {
    //setting variables to their initial state
    _totalDistance = 0.0;
    _coordinates.clear();

    getPolylinePoints(
      origin: origin,
      destination: destination,
    );

    Future.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < _coordinates.length - 1; i++) {
        _totalDistance += _distanceFromCoordinates(
          _coordinates[i].latitude,
          _coordinates[i].longitude,
          _coordinates[i + 1].latitude,
          _coordinates[i + 1].longitude,
        );
      }
      notifyListeners();
    });
    //traversing through each coordinates points of directions
  }

  //calculating the distance between provided coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _distanceFromCoordinates(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void getPolylinePoints({
    required LatLng origin,
    required LatLng destination,
  }) async {
    //getting driving coordinates
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    //getting direction coordinaties if the points are returned through the API
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        _coordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
  }
}
