import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/loading_dialog.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/rating_bar.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/format_datetime.dart';
import 'package:sahayatri/Map_Classes/polylined_map.dart';
import 'package:sahayatri/Services/client_services/payment_service.dart';
import 'package:sahayatri/Services/driver_services/notify_client.dart';
import 'package:sahayatri/Services/driver_services/pending_trips.dart';
import 'package:sahayatri/Services/driver_services/ride_status.dart';

class PendingRides extends StatelessWidget {
  const PendingRides({
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
    required this.payment,
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
  final String payment;
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
    return ResuableCard(
      padding: 12.0,
      absorb: true,
      color: Colors.white,
      disableSplashColor: true,
      height: 285,
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
              SizedBox(
                width: 5.0,
              ),
              (payment == 'paid')
                  ? Icon(
                      Icons.credit_score_rounded,
                      color: Colors.purple,
                    )
                  : Icon(
                      Icons.price_change_rounded,
                      color: Colors.red,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PolyLinedMap(
                          initialLat: initialLat,
                          initialLng: initialLng,
                          destinationLat: destinationLat,
                          destinationLng: destinationLng,
                        ),
                      ),
                    );
                  });
                  return LoadingDialog(text: 'Loading location in the map');
                },
                barrierDismissible: false,
              ),
            },
          ),
          Consumer2<RideStatus, NotifyClient>(
              builder: (context, status, notify, child) {
            if (status.isStarted && (status.rideId == rideId)) {
              return ModalButton(
                text: 'Trip Completed',
                buttonStyle: kButtonStyleSuccess,
                buttonTextStyle: kButtonTextStyle,
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      //sending request to server whenever ride is completed
                      Provider.of<RideStatus>(context, listen: false)
                          .rideOnComplete(clientId: id);
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pop(ctx);
                        //showing error message if not connected to the server
                        if (status.isConnectionError) {
                          displayFlash(
                              context: context,
                              text: 'Can\'t connect to the server!',
                              color: kDangerColor,
                              icon: Icons.wifi_off_rounded);
                        } else {
                          //allowing driver to rate the client
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              Provider.of<PaymentService>(context,
                                      listen: false)
                                  .recordCashPayment(
                                      rideId: rideId,
                                      amount: int.parse(double.parse(price)
                                          .toStringAsFixed(
                                              0))); //string to double and double to int
                              return Rating(id: id);
                            },
                            barrierDismissible: false,
                          );
                          //reloading the list of pending request once a ride is completed
                          Provider.of<DriverPendingRides>(context,
                                  listen: false)
                              .pendingTrips();
                        }
                      });
                      return LoadingDialog(
                          text: 'Closing your deal with $name');
                    },
                    barrierDismissible: false,
                  ),
                },
              );
            }
            return ModalButton(
              text: 'Start the Trip',
              buttonStyle: kButtonStyleBlue,
              buttonTextStyle: kButtonTextStyle,
              onPressed: () => {
                if(formatDate(DateTime.now()) != formatDate(date)){
                  displayFlash(
                        context: context,
                        text: 'Sorry! you can\'t start the trip today.',
                        color: kDangerColor,
                        icon: Icons.event_busy_rounded)
                } else {
                  //for sending notificaiton to the client
                Provider.of<NotifyClient>(context, listen: false)
                    .notifyClient(clientId: id),
                showDialog(
                  context: context,
                  builder: (ctx) {
                    Future.delayed(const Duration(seconds: 2), () {
                      (notify.isConnected)
                          ? Provider.of<RideStatus>(context, listen: false)
                              .started(rideId)
                          : displayFlash(
                              context: context,
                              text: 'Can\'t connect to the server!',
                              color: kDangerColor,
                              icon: Icons.wifi_off_rounded);
                      Navigator.pop(ctx);
                    });
                    return LoadingDialog(text: 'Starting your trip with $name');
                  },
                  barrierDismissible: false,
                )
                }
              },
            );
          }),
        ],
      ),
      onTap: () => null,
    );
  }
}
