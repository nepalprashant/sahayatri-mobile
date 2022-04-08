import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/history_card.dart';
import 'package:sahayatri/Components/no_request.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/client_services/client_ride_history.dart';

class ClientHistory extends StatelessWidget {
  const ClientHistory({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    Provider.of<ClientRideHistory>(context, listen: false).getRideHistory();
    return Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close_rounded,
                color: Colors.black87,
              )),
        ),
        body: RefreshIndicator(
          onRefresh: () => _refresh(context),
          strokeWidth: 2.0,
          color: Color.fromARGB(255, 0, 22, 41),
          child: Column(
            children: [
              ResuableCard(
                  height: 40.0,
                  content: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history_rounded),
                        SizedBox(width: 5.0),
                        Text(
                          'History',
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                  disableTouch: true,
                  color: Colors.white,
                  onTap: () {}),
              Expanded(
                child: Consumer<ClientRideHistory>(
                    builder: (context, history, child) {
                  if (history.anyRides) {
                    return ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: history.rideHistory.length,
                        itemBuilder: (context, int index) {
                          return HistoryCard(
                            //fetching overall trip information
                            date: history.rideHistory[index].scheduledDate,
                            time: history.rideHistory[index].scheduledTime,
                            type: history.rideHistory[index].rideType,
                            distance: history
                                .rideHistory[index].location.totalDistance,
                            price: history.rideHistory[index].totalFare,
                            origin: history.rideHistory[index].location.origin,
                            destination:
                                history.rideHistory[index].location.destination,
                          );
                        });
                  } else if (!history.anyRides && history.isUptoDate) {
                    return ListView(children: [
                      NoRequest(
                          text:
                              'You haven\'t booked any.\nBook your first ride.'),
                    ]);
                  } else if (!history.isConnected) {
                    return ListView(children: [
                      NoRequest(
                          text: 'Sorry! \nCan\'t connect to the server.',
                          noInternet: true),
                    ]);
                  }
                  return ListView(children: [
                    NoRequest(text: 'Wait.... We\'re Fetching \nInformation!')
                  ]);
                }),
              ),
            ],
          ),
        ));
  }
}
