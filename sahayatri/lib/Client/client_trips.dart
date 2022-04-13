import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Client/upcoming_trips.dart';
import 'package:sahayatri/Components/no_request.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/client_services/upcoming_rides.dart';

class ClientTrips extends StatelessWidget {
  const ClientTrips({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    Provider.of<UpcomingRides>(context, listen: false).getUpcomingTrips();
    return Future.delayed(const Duration(seconds: 2), () {});
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
              )),
        ),
        body: RefreshIndicator(
          onRefresh: () => _refresh(context),
          strokeWidth: 2.0,
          color: Color.fromARGB(255, 0, 22, 41),
          child: Column(
            children: [
              ResuableCard(
                  height: 40.0,
                  content: Center(
                    child: Text(
                      'Your Upcoming Trips',
                      style: kTextStyle,
                    ),
                  ),
                  disableTouch: true,
                  color: Colors.white,
                  onTap: () {}),
              Expanded(
                child:
                    Consumer<UpcomingRides>(builder: (context, trips, child) {
                  if (trips.anyTrips) {
                    return ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: trips.upcomingTrips.length,
                        itemBuilder: (context, int index) {
                          return UpcomingTrips(
                            //fetching overall trip information
                            id: trips.upcomingTrips[index].driver.user.id,
                            rideId: trips.upcomingTrips[index].id,
                            name: trips.upcomingTrips[index].driver.user.name,
                            phone:
                                trips.upcomingTrips[index].driver.user.phoneNo,
                            rating: trips
                                .upcomingTrips[index].driver.user.avgRating,
                            date: trips.upcomingTrips[index].scheduledDate,
                            time: trips.upcomingTrips[index].scheduledTime,
                            type: trips.upcomingTrips[index].rideType,
                            payment: trips.upcomingTrips[index].payment,
                            distance: trips
                                .upcomingTrips[index].location.totalDistance,
                            price: trips.upcomingTrips[index].totalFare,
                            origin: trips.upcomingTrips[index].location.origin,
                            destination:
                                trips.upcomingTrips[index].location.destination,
                            initialLat:
                                trips.upcomingTrips[index].location.initialLat,
                            initialLng:
                                trips.upcomingTrips[index].location.initialLng,
                            destinationLat: trips
                                .upcomingTrips[index].location.destinationLat,
                            destinationLng: trips
                                .upcomingTrips[index].location.destinationLng,
                          );
                        });
                  } else if (!trips.anyTrips && trips.isUptoDate) {
                    return ListView(children: [
                      NoRequest(
                          text:
                              'You\'re all covered up.\nNo any upcoming trips.'),
                    ]);
                  } else if (!trips.isConnected) {
                    return ListView(children: [
                      NoRequest(
                          text: 'Sorry! \nCan\'t connect to the server.',
                          noInternet: true),
                    ]);
                  }
                  return ListView(children: [
                    NoRequest(text: 'Wait.... We\'re Fetching \nInformation!')
                  ]);
                }),
              ),
            ],
          ),
        ));
  }
}
