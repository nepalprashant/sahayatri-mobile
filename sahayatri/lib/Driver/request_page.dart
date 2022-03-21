import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/no_request.dart';
import 'package:sahayatri/Components/request_detail_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/driver_services/received_request.dart';
import 'package:sahayatri/Services/driver_services/request_response.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  Future<void> _refresh() async {
    return Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      strokeWidth: 2.0,
      displacement: 100.0,
      color: Color.fromARGB(255, 0, 22, 41),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 60.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Ride Requests',
                style: kTextStyle,
              ),
              SizedBox(height: 15.0),
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
            ],
          ),
        ),
      ),
    );
  }
}

// Consumer<AvailableDrivers>(builder: (context, driver, child) {
//               if (driver.isAvailable) {
//                 return ListView.builder(
//                     controller: controller,
//                     shrinkWrap: true,
//                     itemCount: driver.drivers.length,
//                     itemBuilder: (context, int index) {
//                       return UserCard(
//                         id: driver.drivers[index].id,
//                         name: driver.drivers[index].name,
//                         phone: driver.drivers[index].phoneNo,
//                         vehicle: driver.drivers[index].driver.vehicle
//                             .vehicleType.vehicleType,
//                         rating: driver.drivers[index].ratingAvgRating,
//                         price: driver
//                             .drivers[index].driver.vehicle.vehicleType.fareRate,
//                         context: context,
//                       );
//                     });
//               } else if (!driver.isAvailable && driver.displayError) {
//                 return ListView(
//                   controller: controller,
//                   children: [
//                     ErrorCard(
//                       context: context,
//                     ),
//                   ],
//                 );
//               }
//               return kMapLoading;
//             }),
          
