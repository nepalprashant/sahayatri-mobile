import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/error_card.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/search_bar.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/search_location.dart';
import 'package:sahayatri/Components/driver_detail_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/location_helper.dart';
import 'package:sahayatri/Services/client_services/notify_drivers.dart';
import 'package:sahayatri/Services/map_services/location_name.dart';
import 'package:sahayatri/services/client_services/available_drivers.dart';

class ClientMapPage extends StatefulWidget {
  const ClientMapPage({
    Key? key,
    this.date,
    this.time,
    this.isParcel,
  }) : super(key: key);

  final DateTime? date;
  final TimeOfDay? time;
  final bool? isParcel;

  @override
  _ClientMapPageState createState() => _ClientMapPageState();
}

class _ClientMapPageState extends State<ClientMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = new Set();
  bool _originFlag = false;
  bool _destinationFlag = false;
  bool _displaySearchBar = false;
  // bool _displayPolylines = false;

  late Marker _origin;
  late Marker _destination;

  @override
  void initState() {
    //changing the state of widget after building the whole widget
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<LocationName>(context, listen: false).initialState();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //adding origin marker in the google map
  void _addOriginMarker(LatLng position) {
    setState(() {
      _origin = Marker(
        draggable: true,
        position: position,
        markerId: MarkerId('Origin'),
        infoWindow: InfoWindow(
          title: 'Origin',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(250.0),
        onDragEnd: (newPos) {
          Provider.of<LocationName>(context, listen: false)
              .origin(latLng: newPos);
        },
      );
      Provider.of<LocationName>(context, listen: false)
          .origin(latLng: _origin.position);
      _originFlag = true;
    });
  }

  //adding destination marker in the map
  void _addDestinationMarker(LatLng position) {
    setState(() {
      _destination = Marker(
        draggable: true,
        position: position,
        markerId: MarkerId('Destination'),
        infoWindow: InfoWindow(
          title: 'Destination',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(100.0),
        onDragEnd: (newPos) {
          Provider.of<LocationName>(context, listen: false)
              .destination(latLng: newPos);
        },
      );
      Provider.of<LocationName>(context, listen: false)
          .destination(latLng: _destination.position);
      _destinationFlag = true;
    });
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
                    onTap: (_originFlag)
                        ? _addOriginMarker
                        : (_destinationFlag)
                            ? _addDestinationMarker
                            : null,
                    markers: {
                      if (_originFlag) _origin,
                      if (_destinationFlag) _destination
                    },

                    // polylines: {if (_displayPolylines)
                    //     Polyline(polylineId: const PolygonId('poly'),
                    //     color: Colors.blue, width: 2, points: )
                    //     }
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
            if (!_displaySearchBar) buildFloatingSearchBar(context),
            if (_displaySearchBar)
              SearchLocation(
                onTapDestination: () {
                  setState(() {
                    _originFlag = false;
                  });
                  accessCurrentLocation()
                      .then((position) => _addDestinationMarker(position));
                },
                onTapOrigin: () {
                  setState(() {
                    _destinationFlag = false;
                  });
                  accessCurrentLocation()
                      .then((position) => _addOriginMarker(position));
                },
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 40,
                  width: 250.0,
                  child: Consumer<LocationName>(
                    builder: (context, place, child) {
                      //checking if both origin and destination has been picked
                      if (place.getOrigin && place.getDestinaion) {
                        return ModalButton(
                            buttonStyle: kButtonStyleBlack,
                            buttonTextStyle: kButtonTextStyle,
                            text: (widget.isParcel ?? false)
                                ? 'Request for Pick-up'
                                : 'Request Ride',
                            onPressed: () {
                              if (place.originName != place.destinationName) {
                                //adding relevant information to the rideDetails (Map) from the google map forwarding to the driver
                                rideDetails.addAll({
                                  'initial_lat': _origin.position.latitude,
                                  'initial_lng': _origin.position.longitude,
                                  'destination_lat':
                                      _destination.position.latitude,
                                  'destination_lng':
                                      _destination.position.longitude,
                                  'origin': place.originName,
                                  'destination': place.destinationName,
                                  'total_distance': 12.1,
                                  'total_fare': 1200.75,
                                  'ride_type': (widget.isParcel ?? false)
                                      ? 'parcel'
                                      : 'intercity',
                                  'scheduled_time': widget.time?.toString() ?? TimeOfDay.now().toString(),
                                  'scheduled_date': widget.date?.toIso8601String() ?? DateTime.now().toIso8601String(),
                                });
                                //for polylines in the map
                                // setState(() {
                                //   generatePolylines(
                                //       _origin.position.latitude,
                                //       _origin.position.longitude,
                                //       _destination.position.latitude,
                                //       _destination.position.longitude);
                                //   _displayPolylines = true;
                                //   print('The polyline values $polylines.values');
                                // });
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  )),
                                  builder: (context) => bottomSheet(),
                                );
                                Provider.of<AvailableDrivers>(
                                  context,
                                  listen: false,
                                ).availableDrivers();
                              } else {
                                displayFlash(
                                  context: context,
                                  text: 'Please choose different locations.',
                                  color: Color.fromARGB(255, 134, 10, 1),
                                );
                              }
                            });
                      } else {
                        return ModalButton(
                            buttonStyle: kButtonStyleBlack,
                            buttonTextStyle: kButtonTextStyle,
                            text: 'Set Destination on Map',
                            onPressed: () {
                              accessCurrentLocation().then((position) {
                                _destinationFlag = false;
                                _addOriginMarker(position);
                                Provider.of<LocationName>(context,
                                        listen: false)
                                    .origin(latLng: position);
                              });
                              setState(() {
                                _displaySearchBar = true;
                              });
                            });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
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

  Widget dismiss({required Widget child}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }

  //displaying the available drivers
  Widget bottomSheet() => dismiss(
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.6,
          builder: (_, controller) => Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kCardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child:
                Consumer<AvailableDrivers>(builder: (context, driver, child) {
              if (driver.isAvailable) {
                return ListView.builder(
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: driver.drivers.length,
                    itemBuilder: (context, int index) {
                      return UserCard(
                        id: driver.drivers[index].id,
                        name: driver.drivers[index].name,
                        phone: driver.drivers[index].phoneNo,
                        vehicle: driver.drivers[index].driver.vehicle
                            .vehicleType.vehicleType,
                        rating: driver.drivers[index].ratingAvgRating,
                        price: driver
                            .drivers[index].driver.vehicle.vehicleType.fareRate,
                        context: context,
                      );
                    });
              } else if (!driver.isAvailable && driver.displayError) {
                return ListView(
                  controller: controller,
                  children: [
                    ErrorCard(
                      context: context,
                    ),
                  ],
                );
              }
              return kMapLoading;
            }),
          ),
        ),
      );
}
