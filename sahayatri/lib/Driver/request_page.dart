import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/no_request.dart';
import 'package:sahayatri/Components/request_detail_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/driver_services/driver_availability.dart';
import 'package:sahayatri/Services/driver_services/received_request.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 60.0),
      child: Center(
        child: Column(
          children: [
            Text(
              'Ride Requests',
              style: kTextStyle,
            ),
            SizedBox(height: 15.0),
            Container(
              child:
                  Consumer<ReceivedRequest>(builder: (context, request, child) {
                if (request.isReceived) {
                  var user = request.request.user;
                  var ride = request.request.ride;
                  var location = request.request.ride.location;
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
                return NoRequest();
              }),
            ),
          ],
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
          
