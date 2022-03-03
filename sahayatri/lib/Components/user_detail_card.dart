import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/services/client_services/available_drivers.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

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
                    'N/A',
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
                'Driver Name',
                style: kTextStyle,
              ),
              Spacer(
                flex: 3,
              ),
              Icon(
                Icons.local_taxi,
                color: Colors.amber,
                size: 20.0,
              ),
              Text(
                'Cab',
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
                      '+9779824321005',
                      style: kSmallTextStyle,
                    ),
                  ],
                ),
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber(
                    '+9779824321005',
                  );
                },
              ),
              Spacer(
                flex: 3,
              ),
              Text(
                'Rs. 700',
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
              text: 'Confirm Driver',
              buttonStyle: kButtonStyleBlue,
              buttonTextStyle: kButtonTextStyle,
              onPressed: () => {
                NotificaitonHandler.displayNotificaiton(
                    title: "hello", body: "world", payload: 'aambbo'),
                // displayFlash(context: context, text: 'Vaag Madar'),
                Provider.of<AvailableDrivers>(
                  context,
                  listen: false,
                ).availableDrivers(),
                print('Button Pressed'),
              },
            ),
          )
        ],
      ),
      onTap: () => null,
    );
  }
}
