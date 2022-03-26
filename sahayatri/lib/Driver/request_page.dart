import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/no_request.dart';
import 'package:sahayatri/Driver/request_detail_card.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Driver/pending_rides.dart';
import 'package:sahayatri/Services/driver_services/pending_trips.dart';
import 'package:sahayatri/Services/driver_services/received_request.dart';
import 'package:sahayatri/Services/driver_services/request_response.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    Provider.of<DriverPendingRides>(context, listen: false).pendingTrips();
    return Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      strokeWidth: 2.0,
      displacement: 100.0,
      color: Color.fromARGB(255, 0, 22, 41),
      child: Center(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 45.0),
                  ResuableCard(
                      height: 40.0,
                      content: Center(
                        child: Text(
                          'Ride Requests',
                          style: kTextStyle,
                        ),
                      ),
                      disableTouch: true,
                      color: Colors.white,
                      onTap: () {}),
                  //displaying the received request from the client
                  Consumer2<ReceivedRequest, RequestResponse>(
                      builder: (context, request, response, child) {
                    if (request.isReceived) {
                      //initializing variable of RequestResponse class to fresh one
                      Provider.of<RequestResponse>(context, listen: false)
                          .initialState();
            
                      var user = request.request.user;
                      var ride = request.request.ride;
                      var location = request.request.ride.location;
            
                      // terminating the request incase no response from the driver
                      Future.delayed(const Duration(minutes: 5), () {
                        if (!response.isAccepted && !response.isRejected) {
                          Provider.of<RequestResponse>(context, listen: false)
                              .rejectRequest(clientId: user.id, rideId: ride.id);
                        }
                      });
            
                      return RequestCard(
                        id: user.id,
                        rideId: ride.id,
                        name: user.name,
                        phone: user.phoneNo,
                        rating: user.ratingAvgRating,
                        type: ride.rideType,
                        price: ride.totalFare,
                        date: ride.scheduledDate,
                        time: ride.scheduledTime,
                        origin: location.origin,
                        destination: location.destination,
                        initialLat: location.initialLat,
                        initialLng: location.initialLng,
                        destinationLat: location.destinationLat,
                        destinationLng: location.destinationLng,
                        distance: location.totalDistance,
                      );
                    }
                    return NoRequest(
                      text: 'No new request yet!',
                    );
                  }),
                  ResuableCard(
                      height: 40.0,
                      content: Center(
                        child: Text(
                          'Your Pending Trips',
                          style: kTextStyle,
                        ),
                      ),
                      disableTouch: true,
                      color: Colors.white,
                      onTap: () {}),
                ],
              ),
            ),

            //for displaying the pending requests
            Expanded(
              child: Consumer<DriverPendingRides>(
                  builder: (context, rides, child) {
                if (rides.anyTrips) {
                  return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rides.driverTrips.length,
                      itemBuilder: (context, int index) {
                        return PendingRides(
                          //fetching overall trip information
                          id: rides.driverTrips[index].client.user.id,
                          rideId: rides.driverTrips[index].id,
                          name: rides.driverTrips[index].client.user.name,
                          phone: rides.driverTrips[index].client.user.phoneNo,
                          rating: rides.driverTrips[index].client.user.rating,
                          date: rides.driverTrips[index].scheduledDate,
                          time: rides.driverTrips[index].scheduledTime,
                          type: rides.driverTrips[index].rideType,
                          distance:
                              rides.driverTrips[index].location.totalDistance,
                          price: rides.driverTrips[index].totalFare,
                          origin: rides.driverTrips[index].location.origin,
                          destination:
                              rides.driverTrips[index].location.destination,
                          initialLat:
                              rides.driverTrips[index].location.initialLat,
                          initialLng:
                              rides.driverTrips[index].location.initialLng,
                          destinationLat:
                              rides.driverTrips[index].location.destinationLat,
                          destinationLng:
                              rides.driverTrips[index].location.destinationLng,
                        );
                      });
                } else if (!rides.anyTrips && rides.isUptoDate) {
                  return ListView(children: [
                    NoRequest(
                        text: 'You\'re all covered up.\nNo any pending rides.'),
                  ]);
                } else if (!rides.isConnected) {
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
      ),
    );
  }
}
