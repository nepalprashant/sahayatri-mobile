import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Client/client_main_page.dart';
import 'package:sahayatri/Driver/driver_main_page.dart';
import 'package:sahayatri/screens/no_connection.dart';
import 'package:sahayatri/services/auth.dart';

class GatewayPage extends StatelessWidget {
  const GatewayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          if (auth.authenticated && auth.isClient && !auth.isDriver) {
            return ClientMainPage();
          } else if (auth.authenticated && !auth.isClient && auth.isDriver) {
            return DriverMainPage();
          } else {
            return NoConnection(
              pageLoading: true,
            );
          }
        },
      ),
    );
  }
}
