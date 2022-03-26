import 'package:flutter/material.dart';
import 'package:sahayatri/Client/drawer_menu.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Constants/constants.dart';

class ClientScaffold extends StatelessWidget {
  const ClientScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            onPressed: () {
              displayFlash(
                  context: context,
                  text: 'No new notifications!',
                  icon: Icons.notifications_none_outlined);
            },
            icon: Icon(
              Icons.notifications_outlined,
              size: 30.0,
              color: kInactiveColor,
            ),
          ),
        ],
      ),
      drawer: DrawerMenu(),
      body: body,
    );
  }
}
