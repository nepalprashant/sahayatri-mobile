import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lottie/lottie.dart';
import 'package:sahayatri/Components/loading_dialog.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResuableCard(
      padding: 12.0,
      absorb: true,
      color: Colors.white,
      disableSplashColor: true,
      height: 260,
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
                'Name',
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
                        'From: Tarahara',
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
                        'To: Dharan',
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
                      'Phone',
                      style: kSmallTextStyle,
                    ),
                  ],
                ),
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber(
                    'phone',
                  );
                },
              ),
              Spacer(
                flex: 3,
              ),
              Text(
                'Rs. price',
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
                  Future.delayed(const Duration(seconds: 4), () {
                    Navigator.pop(ctx);
                  });
                  return LoadingDialog(text: 'Confirming the client');
                },
                barrierDismissible: false,
              ),
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 165,
                child: ModalButton(
                  text: 'Accept',
                  buttonStyle: kButtonStyleBlue,
                  buttonTextStyle: kButtonTextStyle,
                  onPressed: () => {
                    NotificationHandler.displayNotificaiton(
                        title: "Connection Error",
                        body: "Can't connect to the server!",
                        payload: 'driverMainPage'),
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        Future.delayed(const Duration(seconds: 4), () {
                          Navigator.pop(ctx);
                        });
                        return LoadingDialog(text: 'Confirming the client');
                      },
                      barrierDismissible: false,
                    ),
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 165,
                child: ModalButton(
                  text: 'Reject',
                  buttonStyle: kButtonStyleRed,
                  buttonTextStyle: kButtonTextStyle,
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        Future.delayed(const Duration(seconds: 4), () {
                          Navigator.pop(ctx);
                        });
                        return LoadingDialog(text: 'Confirming the client');
                      },
                      barrierDismissible: false,
                    ),
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () => null,
    );
  }
}
