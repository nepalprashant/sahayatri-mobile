// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sahayatri/Components/search_bar.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/location_helper.dart';
import 'package:sahayatri/Helper_Classes/map_style_helper.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
    this.backButton,
  }) : super(key: key);
  final bool? backButton;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = new Set();
  bool _markerFlag = false;

  late Marker _origin;
  late Marker _destination;
  late LatLng _newPos;

  @override
  void dispose() {
    super.dispose();
  }

  void _addMarker(LatLng position) {
    setState(() {
      _origin = Marker(
        draggable: true,
        position: position,
        markerId: MarkerId('Origin'),
        infoWindow: InfoWindow(
          title: 'hello',
          snippet: 'Hello world',
        ),
        icon: BitmapDescriptor.defaultMarker,
        onDragEnd: (newPos) {
          setState(() {
            _newPos = LatLng(newPos.latitude, newPos.longitude);
            print(_newPos);
          });
        },
      );
      _markerFlag = true;
    });
  }

  static final Future<CameraPosition> _newLocation =
      accessCurrentLocation().then(
    (value) => CameraPosition(
      target: value,
      zoom: 15.0,
    ),
  );

  Future<void> _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      await _newLocation,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
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
                  onMapCreated: (GoogleMapController controller) async {
                    controller.setMapStyle(snapshot.data![0]);
                    controller.animateCamera(CameraUpdate.newLatLngZoom(
                        await accessCurrentLocation(), 15));
                    _controller.complete(controller);
                  },
                  markers: {if (_markerFlag) _origin},
                );
              }
              return kMapLoading;
            },
          ),
          Positioned(
            top: 20.0,
            child: Row(children: [
              BackButton(
                color: Colors.black87,
              ),
            ]),
          ),
          buildFloatingSearchBar(context),
          Positioned(
            bottom: 25.0,
            left: 110,
            child: ModalButton(
              buttonStyle: kButtonStyleBlack,
              buttonTextStyle: kButtonTextStyle,
              text: 'Set Destination on Map',
              onPressed: () async {
                await accessCurrentLocation()
                    .then((position) => _addMarker(position));
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.gps_fixed_outlined,
          size: 35.0,
        ),
        backgroundColor: Colors.black87,
        onPressed: _currentLocation,
      ),
    );
  }
}
