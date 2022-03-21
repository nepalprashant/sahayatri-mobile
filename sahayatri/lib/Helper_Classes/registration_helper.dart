import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/screens/no_connection.dart';
import 'package:sahayatri/services/register_user.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<RegisterUser>(
        builder: (context, register, child) {
          Future.delayed(
            const Duration(seconds: 4),
            () {
              if (register.registered) {
                Navigator.popAndPushNamed(
                  context,
                  'login',
                  result: displayFlash(
                    context: context,
                    icon: Icons.info_outline,
                    text: 'You\'re registered, Login now!',
                  ),
                );
              } else if (!register.registered) {
                Navigator.popAndPushNamed(
                  context,
                  'signup',
                  result: displayFlash(
                    context: context,
                    icon: Icons.warning_amber_outlined,
                    text: (register.errorStatus != null)
                        ? 'User credentials matched our record!'
                        : 'Can\'t connect to the server!',
                    color: Color.fromARGB(255, 134, 10, 1),
                  ),
                );
              }
            },
          );
          return NoConnection(
            pageLoading: true,
          );
        },
      ),
    );
  }
}
