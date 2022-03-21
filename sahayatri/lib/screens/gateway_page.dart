import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Client/client_main_page.dart';
import 'package:sahayatri/Components/flash_bar.dart';
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
          }
          Future.delayed(const Duration(seconds: 4), () {
            if (!auth.authenticated) {
              Navigator.popAndPushNamed(context, 'login',
                  result: displayFlash(
                    context: context,
                    icon: (auth.fromLogout)
                        ? Icons.info_outline
                        : Icons.warning_amber_outlined,
                    text: (auth.fromLogout)
                        ? 'You\'re Logged Out!'
                        : 'Errors Encountered',
                    color: (auth.fromLogout)
                        ? Colors.black
                        : Color.fromARGB(255, 134, 10, 1),
                  ));
            }
          });
          return NoConnection(
            pageLoading: true,
          );
        },
      ),
    );
  }
}
