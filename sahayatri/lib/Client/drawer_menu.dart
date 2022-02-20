import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/drawer_tile.dart';
import 'package:sahayatri/Components/legal_info.dart';
import 'package:sahayatri/screens/no_connection.dart';
import 'package:sahayatri/services/auth.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Auth>(builder: (context, auth, child) {
        if (auth.authenticated) {
          return ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF181818),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Lottie.asset('assets/lotties/avatar.json'),
                      backgroundColor: Colors.white,
                      radius: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      auth.user.userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                  ],
                ),
              ),
              Tile(
                icon: Icons.star,
                text: '5.0',
              ),
              Tile(
                icon: Icons.local_taxi_outlined,
                text: 'Your Trips',
                onTap: () => Navigator.pop(context),
              ),
              Tile(
                icon: Icons.manage_accounts_outlined,
                text: 'Update Account',
                onTap: () => Navigator.pop(context),
              ),
              Tile(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                  onTap: () => Navigator.pop(context)),
              Tile(
                icon: Icons.support_agent_outlined,
                text: 'Help',
                onTap: () => Navigator.pop(context),
              ),
              Tile(
                icon: Icons.info_outlined,
                text: 'App Info',
                onTap: () => legalInfo(context),
              ),
              Tile(
                  icon: Icons.logout_outlined,
                  text: 'Log Out',
                  onTap: () {
                    Provider.of<Auth>(
                      context,
                      listen: false,
                    ).clientLogout();
                  }),
            ],
          );
        }
        return NoConnection();
      }),
    );
  }
}
