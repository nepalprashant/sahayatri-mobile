import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Client/client_main_page.dart';
import 'package:sahayatri/services/auth.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      nextScreen: LoginPage(),
    );
  }
}

// Center(
//         child: Consumer<Auth>(
//         builder: (context, auth, child) {
//           if (!auth.authenticated) {
//             return ClientMainPage();
//           } else {
//             return LoginPage();
//           }
//         },
//       ),
//       ),
