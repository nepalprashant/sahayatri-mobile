import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';

class NoRequest extends StatelessWidget {
  const NoRequest({ 
    Key? key, 
  required this.text,
  this.noInternet,
  }) : super(key: key);

  final String text;
  final bool? noInternet;

  @override
  Widget build(BuildContext context) {
    return ResuableCard(
      padding: 12.0,
      absorb: true,
      color: Colors.white,
      disableSplashColor: true,
      height: 155,
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
                    height: (noInternet ?? false) ? 131 : 110.0,
                    width: 150.0,
                    child: (noInternet ?? false) ? Lottie.asset(
                      'assets/lotties/noInternet.json',
                      fit: BoxFit.fill,
                    ) : Lottie.asset(
                      'assets/lotties/mapLoading.json',
                      fit: BoxFit.fill,
                    )
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