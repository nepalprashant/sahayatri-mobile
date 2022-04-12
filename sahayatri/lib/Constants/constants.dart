import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

late String accessToken;
late int userId;
late String apiKey;

const kWelcomeTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 20,
);

const kDivider = Divider(
  thickness: 3.0,
  color: Color(0x61000000),
  endIndent: 70.0,
  indent: 70.0,
);

const kPrimaryColor = Color(0xFFC4C4C4);

const kTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  color: Colors.black87,
);

const kMediumTextStyle = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 16.0,
  color: Colors.black87,
);

const kTextStyleWhite = TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

const kCardColor = Color(0xFFFECEFF1);

const kButtonTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  color: Colors.white,
);

ButtonStyle kButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
  Colors.black54,
));

ButtonStyle kButtonStyleBlue = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
  Colors.purpleAccent,
));

ButtonStyle kButtonStyleSuccess = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
  Color.fromARGB(255, 29, 172, 0),
));

ButtonStyle kButtonStyleRed = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
  Colors.redAccent,
));

ButtonStyle kButtonStyleBlack = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
  Colors.black87,
));

const kTitleText = Text(
  'saha-yatri',
  style: TextStyle(
    fontFamily: 'Namaste',
    fontSize: 25.0,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  ),
);

const kVerticalDivider = VerticalDivider(
  color: Colors.black45,
  thickness: 3.0,
  endIndent: 25.0,
  indent: 25.0,
);

SizedBox kLoginImage = SizedBox(
  height: 150.0,
  width: 200.0,
  child: Lottie.asset('assets/lotties/login.json'),
);

const kSmallTextStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w800,
  color: Colors.black54,
);

Widget kLoading = Center(
  child: Container(
    color: Colors.white,
    height: 200.0,
    width: 200.0,
    child: Lottie.asset(
      'assets/lotties/loading.json',
      fit: BoxFit.fill,
    ),
  ),
);

Widget kMapLoading = Center(
  child: Container(
    height: 200.0,
    width: 200.0,
    child: Lottie.asset(
      'assets/lotties/mapLoading.json',
      fit: BoxFit.fill,
    ),
  ),
);

Widget kNoInternet = Center(
  child: Container(
    height: 200.0,
    width: 200.0,
    child: Lottie.asset(
      'assets/lotties/noInternet.json',
      fit: BoxFit.fill,
    ),
  ),
);

Color kActiveColor = Colors.lightBlue;

Color kInactiveColor = Colors.black87;

TextStyle kHeadingTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
  color: Colors.black87,
);

TextStyle kChartTitleStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

TextStyle kChartLabelStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 10.0,
);

Color kDangerColor = Color.fromARGB(255, 134, 10, 1);