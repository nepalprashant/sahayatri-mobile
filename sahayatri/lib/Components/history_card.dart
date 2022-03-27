import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/format_datetime.dart';
import 'package:sahayatri/Services/client_services/cancel_trip.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.date,
    required this.time,
    required this.type,
    required this.origin,
    required this.destination,
    required this.price,
    required this.distance,
  }) : super(key: key);

  final DateTime date;
  final String time;
  final String type;
  final String distance;
  final String price;
  final String origin;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return Consumer<CancleTrip>(builder: (context, status, child) {
      return ResuableCard(
        padding: 12.0,
        absorb: true,
        color: Colors.white,
        disableSplashColor: true,
        height: 145,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${formatDate(date)}, [${stringToTime(context, time)}]',
                  style: kTextStyle,
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Type: $type',
                      style: kSmallTextStyle,
                    ),
                  ],
                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Color.fromARGB(255, 0, 54, 99),
                      size: 20.0,
                    ),
                    Text(
                      'From: $origin',
                      style: kSmallTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Color.fromARGB(255, 29, 172, 0),
                      size: 20.0,
                    ),
                    Text(
                      'To: $destination',
                      style: kSmallTextStyle,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  'Amount: Rs. $price',
                  style: kTextStyle,
                ),
                Spacer(flex: 3,),
                Text(
                  'Distance: [$distance Km]',
                  style: kTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
        onTap: () => null,
      );
    });
  }
}
