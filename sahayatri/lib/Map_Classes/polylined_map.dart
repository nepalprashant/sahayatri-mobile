import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/location_helper.dart';

class PolyLinedMap extends StatefulWidget {
  const PolyLinedMap(
      {Key? key,
      required this.initialLat,
      required this.initialLng,
      required this.destinationLat,
      required this.destinationLng})
      : super(key: key);

  final String initialLat;
  final String initialLng;
  final String destinationLat;
  final String destinationLng;

  @override
  _PolyLinedMapState createState() => _PolyLinedMapState();
}

class _PolyLinedMapState extends State<PolyLinedMap> {
  //for displaying the marker in the map
  final Set<Marker> markers = new Set();

  Completer<GoogleMapController> _controller = Completer();

  Set<Polyline> _polylines = Set<Polyline>();

  //defining the object
  late PolylinePoints polylinePoints;

//coordinates to join routes
  List<LatLng> coordinates = [];

//sotred polyline coordinates
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
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

  //adding origin marker in the google map
  void _addOriginMarker(LatLng position) {
    setState(() {
      markers.add(Marker(
        position: position,
        markerId: MarkerId('Origin'),
        infoWindow: InfoWindow(
          title: 'Origin',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(250.0),
      ));
    });
  }

  //adding destination marker in the map
  void _addDestinationMarker(LatLng position) {
    setState(() {
      markers.add(Marker(
        draggable: true,
        position: position,
        markerId: MarkerId('Destination'),
        infoWindow: InfoWindow(
          title: 'Destination',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(100.0),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close_rounded,
            color: Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              //animating camera to the origin marker
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(double.parse(widget.initialLat),
                          double.parse(widget.initialLng)),
                      zoom: 15.0,
                      tilt: 60.0)));
            },
            child: Row(
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.purple,
                ),
                Text(
                  'From',
                  style: kTextStyle,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              //animating camera to the destination marker
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(double.parse(widget.destinationLat),
                          double.parse(widget.destinationLng)),
                      zoom: 15.0,
                      tilt: 60.0)));
            },
            child: Row(
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.amberAccent,
                ),
                Text(
                  'To',
                  style: kTextStyle,
                )
              ],
            ),
          )
        ],
      ),
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
                      //Displaying the origin while opening the map
                      target: LatLng(double.parse(widget.initialLat),
                          double.parse(widget.initialLng)),
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) async {
                      //adding polylines in the map
                      setPolylines();
                      //adding markers in the map
                      _addOriginMarker(LatLng(double.parse(widget.initialLat),
                          double.parse(widget.initialLng)));
                      _addDestinationMarker(LatLng(
                          double.parse(widget.destinationLat),
                          double.parse(widget.destinationLng)));
                      controller.animateCamera(CameraUpdate.newLatLngZoom(
                          await accessCurrentLocation(), 15));
                      _controller.complete(controller);
                    },
                    markers: markers,
                    polylines: _polylines,
                  );
                }
                return kMapLoading;
              },
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.black87, // button color
                        child: InkWell(
                          splashColor: Colors.teal, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.zoom_in_rounded,
                                color: Colors.white),
                          ),
                          onTap: () async {
                            //for zooming into the map
                            final GoogleMapController controller =
                                await _controller.future;
                            controller.animateCamera(CameraUpdate.zoomIn());
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.black87, // button color
                        child: InkWell(
                          splashColor: Colors.teal, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.zoom_out_rounded,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () async {
                            //for zooming out in the map
                            final GoogleMapController controller =
                                await _controller.future;
                            controller.animateCamera(CameraUpdate.zoomOut());
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
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

  void setPolylines() async {
    //getting driving coordinates
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(
          double.parse(widget.initialLat), double.parse(widget.initialLng)),
      PointLatLng(double.parse(widget.destinationLat),
          double.parse(widget.destinationLng)),
      travelMode: TravelMode.driving,
    );

    //getting direction coordinaties if the points are returned through the API
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        coordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
          width: 6,
          polylineId: PolylineId(
            'polyline',
          ),
          color: Colors.black87,
          points: coordinates,
        ));
      });
    }
  }
}
