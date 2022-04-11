import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Client/client_history.dart';
import 'package:sahayatri/Client/client_map_page.dart';
import 'package:sahayatri/Client/client_trips.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Driver/driver_history.dart';
import 'package:sahayatri/Driver/driver_main_page.dart';
import 'package:sahayatri/Helper_Classes/registration_helper.dart';
import 'package:sahayatri/Screens/forgot_password_page.dart';
import 'package:sahayatri/Services/client_services/cancel_trip.dart';
import 'package:sahayatri/Services/client_services/client_ride_history.dart';
import 'package:sahayatri/Services/client_services/provide_rating.dart';
import 'package:sahayatri/Services/client_services/upcoming_rides.dart';
import 'package:sahayatri/Services/driver_services/driver_availability.dart';
import 'package:sahayatri/Services/driver_services/driver_ride_history.dart';
import 'package:sahayatri/Services/driver_services/notify_client.dart';
import 'package:sahayatri/Services/driver_services/pending_trips.dart';
import 'package:sahayatri/Services/driver_services/received_request.dart';
import 'package:sahayatri/Services/driver_services/request_response.dart';
import 'package:sahayatri/Services/driver_services/ride_status.dart';
import 'package:sahayatri/Services/forgot_password.dart';
import 'package:sahayatri/Services/map_services/location_name.dart';
import 'package:sahayatri/Services/record_rating.dart';
import 'package:sahayatri/screens/gateway_page.dart';
import 'package:sahayatri/screens/login_page.dart';
import 'package:sahayatri/Client/client_main_page.dart';
import 'package:sahayatri/screens/map_page.dart';
import 'package:sahayatri/screens/no_connection.dart';
import 'package:sahayatri/services/auth.dart';
import 'package:sahayatri/screens/signup_page.dart';
import 'package:sahayatri/services/client_services/available_drivers.dart';
import 'package:sahayatri/services/connectivity.dart';
import 'package:sahayatri/services/previous_login.dart';
import 'package:sahayatri/services/register_user.dart';
import 'screens/splash_screen.dart';
import 'package:dcdg/dcdg.dart';

void main() {
  runApp(
    //initializing multiple providers for project
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Connectivity()),
        ChangeNotifierProvider(create: (context) => PreviousLogin()),
        ChangeNotifierProvider(create: (context) => RegisterUser()),
        ChangeNotifierProvider(create: (context) => AvailableDrivers()),
        ChangeNotifierProvider(create: (context) => LocationName()),
        ChangeNotifierProvider(create: (context) => ChangeAvailability()),
        ChangeNotifierProvider(create: (context) => ReceivedRequest()),
        ChangeNotifierProvider(create: (context) => RequestResponse()),
        ChangeNotifierProvider(create: (context) => DriverPendingRides()),
        ChangeNotifierProvider(create: (context) => RideStatus()),
        ChangeNotifierProvider(create: (context) => RecordRating()),
        ChangeNotifierProvider(create: (context) => UpcomingRides()),
        ChangeNotifierProvider(create: (context) => CancleTrip()),
        ChangeNotifierProvider(create: (context) => ProvideRating()),
        ChangeNotifierProvider(create: (context) => ClientRideHistory()),
        ChangeNotifierProvider(create: (context) => DriverRideHistory()),
        ChangeNotifierProvider(create: (context) => NotifyClient()),
        ChangeNotifierProvider(create: (context) => ForgotPassword()),
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
        //initializing different routes
        routes: {
          '/': (context) => SplashScreen(),
          'map': (context) => MapPage(),
          'login': (context) => LoginPage(),
          'signup': (context) => SignupPage(),
          'forgotPassword': (context) => ForgotPasswordPage(),
          'registration': (context) => Registration(),
          'gatewayPage': (context) => GatewayPage(),
          'clientMainPage': (context) => ClientMainPage(),
          'noInternet': (context) => NoConnection(),
          'driverMainPage': (context) => DriverMainPage(),
          'clientMapPage': (context) => ClientMapPage(),
          'driverMapPage': (context) => DriverMainPage(),
          'clientTrips': (context) => ClientTrips(),
          'clientHistory': (context) => ClientHistory(),
          'driverHistory': (context) => DriverHistory(),
        });
  }
}
