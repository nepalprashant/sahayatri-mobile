import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sahayatri/Components/search_bar.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/location_helper.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //changing camera position
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
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: Future.wait([accessCurrentLocation()]),
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
                      target: snapshot.data![0],
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) async {
                      controller.animateCamera(CameraUpdate.newLatLngZoom(
                          await accessCurrentLocation(), 15));
                      _controller.complete(controller);
                    },
                  );
                }
                return kMapLoading;
              },
            ),
            buildFloatingSearchBar(context),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 5.0),
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            child: Icon(
              Icons.gps_fixed_outlined,
              size: 33.0,
            ),
            backgroundColor: Colors.black87,
            onPressed: _currentLocation,
          ),
        ),
      ),
    );
  }
}
