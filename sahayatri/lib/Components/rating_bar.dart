import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/loading_dialog.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/client_services/provide_rating.dart';
import 'package:sahayatri/Services/record_rating.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    //initial rate
    double rate = 3;
    return Consumer<RecordRating>(builder: (context, record, child) {
      return AlertDialog(
        title: Column(
          children: [
            Text(
              'How was your experience?',
              style: kMediumTextStyle,
            ),
            SizedBox(height: 10.0),
            RatingBar.builder(
              initialRating: rate,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return Icon(
                      Icons.sentiment_very_satisfied,
                      color: Color.fromARGB(255, 25, 7, 187),
                    );
                  default:
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Color.fromARGB(255, 0, 22, 41)),
                      strokeWidth: 3.0,
                    );
                }
              },
              onRatingUpdate: (rating) {
                rate = rating;
                print(rate);
              },
            ),
            SizedBox(height: 10.0),
            SizedBox(
              width: 250.0,
              child: ModalButton(
                text: 'Submit',
                buttonStyle: kButtonStyleBlue,
                buttonTextStyle: kButtonTextStyle,
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      Provider.of<RecordRating>(context, listen: false)
                          .recordRating(id: id, rate: rate);
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pop(ctx);
                        //checking if connected to the internet
                        if (!record.isConnectionError) {
                          Navigator.pop(context);
                          Provider.of<ProvideRating>(context, listen: false).ratingSubmitted();
                          displayFlash(
                              context: context,
                              text: 'Response Recorded!',
                              icon: Icons.reply_sharp);
                        } else {
                          displayFlash(
                              context: context,
                              text: 'Can\'t connect to the server!',
                              color: kDangerColor,
                              icon: Icons.wifi_off_rounded);
                        }
                      });
                      return LoadingDialog(text: 'Recording your response.');
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
    });
  }
}
