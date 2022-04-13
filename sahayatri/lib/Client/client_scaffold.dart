import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Client/drawer_menu.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/payment_dialog.dart';
import 'package:sahayatri/Components/rating_bar.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/client_services/payment_service.dart';
import 'package:sahayatri/Services/client_services/provide_rating.dart';

class ClientScaffold extends StatelessWidget {
  ClientScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: Consumer2<ProvideRating, PaymentService>(
          builder: (context, rating, payment, child) {
        //for preventing from build error
        Future.delayed(const Duration(seconds: 0), () {
          if (rating.rideCompleted) {
            //for displaying the raitng bar
            Provider.of<ProvideRating>(context, listen: false)
                .ratingSubmitted();
            showDialog(
              context: _scaffoldKey.currentContext!,
              builder: (ctx) {
                return Rating(id: rating.driverId);
              },
              barrierDismissible: false,
            );
          }
          if (payment.initiatePayment) {
            //for displaying the payment options
            showDialog(
              context: _scaffoldKey.currentContext!,
              builder: (ctx) {
                return Payment(amount: payment.amount, rideId: payment.rideId);
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
