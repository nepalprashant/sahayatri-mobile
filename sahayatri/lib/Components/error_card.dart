import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
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
              Column(
                children: [
                  Text(
                    'Sorry! We can\'t find anyone. \nTry Again Later!',
                    style: kTextStyle,
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Container(
                    height: 110.0,
                    width: 150.0,
                    child: Lottie.asset(
                      'assets/lotties/mapLoading.json',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: 120.0,
            child: ModalButton(
              text: 'Abort',
              buttonStyle: kButtonStyleBlue,
              buttonTextStyle: kButtonTextStyle,
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
          )
        ],
      ),
      onTap: () => null,
    );
  }
}
