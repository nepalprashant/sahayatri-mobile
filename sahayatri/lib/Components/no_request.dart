import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';

class NoRequest extends StatelessWidget {
  const NoRequest({ 
    Key? key, 
  required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ResuableCard(
      padding: 12.0,
      absorb: true,
      color: Colors.white,
      disableSplashColor: true,
      height: 150,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    text,
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
        ],
      ),
      onTap: () => null,
    );
  
  }
}