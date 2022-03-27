import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Client/drawer_menu.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/rating_bar.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/client_services/provide_rating.dart';

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
                  icon: Icons.notifications_rounded);
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
      body: Consumer<ProvideRating>(builder: (context, rating, child) {
        //for preventing from build error
        Future.delayed(const Duration(seconds: 0), () {
          if (rating.rideCompleted) {
            //for displaying the raitng bar once
            Provider.of<ProvideRating>(context, listen: false)
                .ratingSubmitted();
            showDialog(
              context: context,
              builder: (ctx) {
                return Rating(id: rating.driverId);
              },
              barrierDismissible: false,
            );
          }
        });
        return body;
      }),
    );
  }
}
