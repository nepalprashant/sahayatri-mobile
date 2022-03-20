import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/loading_dialog.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/client_services/notify_drivers.dart';
import 'package:sahayatri/Services/map_services/location_name.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.id,
    required this.context,
    required this.name,
    required this.phone,
    required this.vehicle,
    required this.rating,
    required this.price,
  }) : super(key: key);

  final BuildContext context;
  final int id;
  final String name;
  final String phone;
  final String vehicle;
  final double rating;
  final String price;

  @override
  Widget build(BuildContext context) {
    return ResuableCard(
      padding: 12.0,
      absorb: true,
      color: Colors.white,
      disableSplashColor: true,
      height: 192,
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
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.blue,
                  ),
                  Text(
                    (rating != 0) ? rating.toStringAsFixed(1) : 'N/A',
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
              Icon(
                (() {
                  if (vehicle == 'bike') {
                    return Icons.two_wheeler;
                  } else if (vehicle == 'cab') {
                    return Icons.local_taxi;
                  }
                  return Icons.moped;
                }()),
                color: Colors.amber,
                size: 20.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                vehicle,
                style: kSmallTextStyle,
              )
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
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: 120.0,
            child: ModalButton(
              text: 'Request Driver',
              buttonStyle: kButtonStyleBlue,
              buttonTextStyle: kButtonTextStyle,
              onPressed: () => {
                notifyDriver(driverId: id),
                Navigator.pop(context),
                showDialog(
                  context: context,
                  builder: (ctx) {
                    Future.delayed(const Duration(seconds: 4), () {
                      Provider.of<LocationName>(ctx, listen: false).initialState();
                      Navigator.pop(ctx);
                    });
                    return LoadingDialog(text: 'Requesting the rider');
                  },
                  barrierDismissible: false,
                ),
              },
            ),
          )
        ],
      ),
      onTap: () => null,
    );
  }
}
