import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Driver/driver_main_page.dart';
import 'package:sahayatri/screens/gateway_page.dart';
import 'package:sahayatri/screens/login_page.dart';
import 'package:sahayatri/Client/client_main_page.dart';
import 'package:sahayatri/screens/map_page.dart';
import 'package:sahayatri/screens/no_connection.dart';
import 'package:sahayatri/services/auth.dart';
import 'package:sahayatri/screens/signup_page.dart';
import 'package:sahayatri/services/change_toggle.dart';
import 'package:sahayatri/services/connectivity.dart';
import 'package:sahayatri/services/previous_login.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Connectivity()),
        ChangeNotifierProvider(create: (context) => ChangeToggle()),
        ChangeNotifierProvider(create: (context) => PreviousLogin()),
      ],
      child: Sahayatri(),
    ),
  );
}

class Sahayatri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //removing the debugging banner
        debugShowCheckedModeBanner: false,
        //applying default style for the application
        theme: ThemeData.light().copyWith(
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Poppins',
              ),
          primaryTextTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Poppins',
              ),
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
          fontFamily: 'Poppins',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          'map': (context) => MapPage(),
          'login': (context) => LoginPage(),
          'signup': (context) => SignupPage(),
          'gatewayPage': (context) => GatewayPage(),
          'clientMainPage': (context) => ClientMainPage(),
          'noInternet': (context) => NoConnection(),
          'driverMainPage': (context) => DriverMainPage(),
        });
  }
}
