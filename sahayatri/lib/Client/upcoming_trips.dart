import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/loading_dialog.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/format_datetime.dart';
import 'package:sahayatri/Services/client_services/cancel_trip.dart';
import 'package:sahayatri/Services/client_services/upcoming_rides.dart';

class UpcomingTrips extends StatelessWidget {
  const UpcomingTrips({
    Key? key,
    required this.id,
    required this.rideId,
    required this.name,
    required this.phone,
    required this.rating,
    required this.date,
    required this.time,
    required this.type,
    required this.origin,
    required this.destination,
    required this.price,
    required this.distance,
    required this.initialLat,
    required this.initialLng,
    required this.destinationLat,
    required this.destinationLng,
  }) : super(key: key);

  final int id;
  final int rideId;
  final String name;
  final String phone;
  final double rating;
  final DateTime date;
  final String time;
  final String type;
  final String distance;
  final String price;
  final String origin;
  final String destination;
  final String initialLat;
  final String initialLng;
  final String destinationLat;
  final String destinationLng;

  @override
  Widget build(BuildContext context) {
    return Consumer<CancleTrip>(builder: (context, status, child) {
      return ResuableCard(
        padding: 12.0,
        absorb: true,
        color: Colors.white,
        disableSplashColor: true,
        height: 280,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Lottie.asset('assets/lotties/avatar.json'),
                  backgroundColor: Colors.white,
                  radius: 25.0,
                ),
                Spacer(
                  flex: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    Text(
                      (rating != 0) ? rating.toStringAsFixed(1) : 'N/A',
                      style: kSmallTextStyle,
                    ),
                    Text(
                      'Scheduled:  ${formatDate(date)}, [${stringToTime(context, time)}]',
                      style: kSmallTextStyle,
                    ),
                    Text(
                      'Type: $type',
                      style: kSmallTextStyle,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  name,
                  style: kTextStyle,
                ),
                Spacer(
                  flex: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: Color.fromARGB(255, 0, 54, 99),
                          size: 20.0,
                        ),
                        Text(
                          'From: $origin',
                          style: kSmallTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: Color.fromARGB(255, 29, 172, 0),
                          size: 20.0,
                        ),
                        Text(
                          'To: $destination',
                          style: kSmallTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Colors.blue,
                        size: 20.0,
                      ),
                      Text(
                        phone,
                        style: kSmallTextStyle,
                      ),
                    ],
                  ),
                  onTap: () async {
                    await FlutterPhoneDirectCaller.callNumber(
                      phone,
                    );
                  },
                ),
                Spacer(
                  flex: 3,
                ),
                Text(
                  'Rs. $price',
                  style: kTextStyle,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '[$distance Km]',
                  style: kTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            ModalButton(
              text: 'View in Map',
              buttonStyle: kButtonStyleBlack,
              buttonTextStyle: kButtonTextStyle,
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(ctx);
                    });
                    return LoadingDialog(text: 'Loading location in the map');
                  },
                  barrierDismissible: false,
                ),
              },
            ),
            ModalButton(
              text: 'Cancel Trip',
              buttonStyle: kButtonStyleRed,
              buttonTextStyle: kButtonTextStyle,
              onPressed: () => {
                //calling provider to send request to backend for cancelling the trip
                Provider.of<CancleTrip>(context, listen: false)
                    .cancleTrip(driverId: id, rideId: rideId),
                showDialog(
                  context: context,
                  builder: (ctx) {
                    Future.delayed(const Duration(seconds: 2), () {
                      // checking if the upcoming trip is one hour from now
                      if (formatDate(DateTime.now()) == date &&
                          TimeOfDay.now().hour >=
                              stringToTimeOfDay(time).hour) {
                        displayFlash(
                            context: context,
                            text: 'Sorry! you can\'t cancel the trip now.',
                            color: kDangerColor,
                            icon: Icons.event_busy_rounded);
                      } else if (!status.isConnected) {
                        displayFlash(
                            context: context,
                            text: 'Can\'t connect to the server!',
                            color: kDangerColor,
                            icon: Icons.wifi_off_rounded);
                      } else {
                        //reloading the list of upcoming trips
                        Provider.of<UpcomingRides>(context, listen: false)
                            .getUpcomingTrips();
                        displayFlash(
                            context: context,
                            text: 'You\'ve cancelled the trip.',
                            color: kDangerColor,
                            icon: Icons.delete_forever_rounded);
                      }
                      Navigator.pop(ctx);
                      // Provider.of<ReceivedRequest>(context, listen: false)
                      //     .changeStatus();
                    });
                    return LoadingDialog(text: 'Terminating your Request.');
                  },
                  barrierDismissible: false,
                ),
              },
            ),
          ],
        ),
        onTap: () => null,
      );
    });
  }
}
