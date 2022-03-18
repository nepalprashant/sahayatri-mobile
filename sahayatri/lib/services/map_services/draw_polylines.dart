import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sahayatri/Helper_Classes/config_helper.dart';

//defining the object
late PolylinePoints polylinePoints;

//coordinates to join
List<LatLng> coordinates = [];

//sotred polyline coordinates
Map<PolylineId, Polyline> polylines = {};

//method for creating the polylines
void generatePolylines(
  double originLat,
  double originLng,
  double destinationLat,
  double destinationLng,
) async {
  //declaring the points
  polylinePoints = PolylinePoints();

  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    renderConfigFile().then((value) => value['api_key']).toString(),
    PointLatLng(originLat, originLng),
    PointLatLng(destinationLat, destinationLng),
    travelMode: TravelMode.transit,
  );

  //listing the coordinate points
  if (result.points.isNotEmpty) {
    result.points.forEach((PointLatLng pnt) {
      coordinates.add(LatLng(pnt.latitude, pnt.longitude));
    });
  }

  PolylineId identifier = PolylineId('id');

  Polyline polyline = Polyline(
    polylineId: identifier,
    color: Colors.blue,
    points: coordinates,
    width: 2,
  );

  polylines[identifier] = polyline;
}
