import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/loading_dialog.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/client_services/payment_service.dart';
import 'package:sahayatri/Services/client_services/upcoming_rides.dart';

class Payment extends StatelessWidget {
  Payment({
    Key? key,
    required this.amount,
    required this.rideId,
  }) : super(key: key);

  final int amount;
  final int rideId;

  @override
  Widget build(BuildContext context) {
    //configuring the payment configurations
    final config = PaymentConfig(
      amount: amount * 100, // Amount in paisa
      productIdentity: 'Rides',
      productName: 'Saha-Yatri',
      mobile: '9800000001', // For mobile number
    );

    return AlertDialog(
      title: Column(
        children: [
          Text(
            'Proceed for payment?',
            style: kMediumTextStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            child: Lottie.asset(
              'assets/lotties/payment.json',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 300.0,
            child: KhaltiButton(
              style: kButtonStyleBlue,
              config: config,
              preferences: [
                // enabling different payment methods.
                PaymentPreference.khalti,
                PaymentPreference.connectIPS,
                PaymentPreference.eBanking,
              ],
              onSuccess: (successModel) {
                // Perform Server Verification
                //storing payment details
                Provider.of<PaymentService>(context, listen: false)
                    .recordOnlinePayment(rideId: rideId, amount: amount);
                //closing the payment dialog
                Provider.of<PaymentService>(context, listen: false)
                    .paymentSuccess();
                //reloading the list of upcoming rides
                Provider.of<UpcomingRides>(context, listen: false)
                    .getUpcomingTrips();
                Navigator.pop(context);
                displayFlash(
                    context: context,
                    text: 'Payment Success',
                    icon: Icons.payment_rounded);
              },
              onFailure: (failureModel) {
                // To Do on failure
                displayFlash(
                    context: context,
                    text: 'Errors Encountered',
                    icon: Icons.credit_card_off_rounded,
                    color: kDangerColor);
              },
            ),
          ),
          SizedBox(
            width: 300.0,
            child: ModalButton(
              text: 'Pay Later in Cash',
              buttonStyle: kButtonStyleRed,
              buttonTextStyle: kButtonTextStyle,
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(ctx);
                      Provider.of<PaymentService>(context, listen: false)
                          .paymentSuccess();
                      Navigator.pop(context);
                      displayFlash(
                          context: context,
                          text: 'Response Recorded',
                          icon: Icons.rocket_launch_rounded);
                    });
                    return LoadingDialog(
                        text: 'Recording your payment preference');
                  },
                  barrierDismissible: false,
                ),
              },
            ),
          ),
        ],
      ),
      elevation: 24.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
