import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/location_helper.dart';
import 'package:sahayatri/Helper_Classes/map_style_helper.dart';

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    return FutureBuilder(
      future: Future.wait([renderMapStyle(), accessCurrentLocation()]),
      builder: (
        BuildContext buildContext,
        AsyncSnapshot<List<dynamic>> snapshot,
      ) {
        if (snapshot.hasData) {
          return GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: snapshot.data![1],
              zoom: 15.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(snapshot.data![0]);
              _controller.complete(controller);
            },
          );
        }
        return kMapLoading;
      },
    );
  }
}
