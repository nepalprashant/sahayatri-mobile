import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/screens/gateway_page.dart';
import 'package:sahayatri/services/previous_login.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<PreviousLogin>(context, listen: false).getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Text(
          'saha-yatri',
          style: TextStyle(
            fontFamily: 'Namaste',
            fontSize: 50.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      nextScreen: Consumer<PreviousLogin>(
        builder: (context, status, child) {
          if (status.previousLogin) {
            status.accessUser(context);
            return GatewayPage();
          }
          return LoginPage();
        },
      ),
    );
  }
}
