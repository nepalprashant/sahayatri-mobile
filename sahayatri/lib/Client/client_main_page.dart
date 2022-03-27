import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Client/client_map_page.dart';
import 'package:sahayatri/Client/client_scaffold.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/icon_card.dart';
import 'package:sahayatri/Components/map.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Events/client_events/client_channel_subscriptions.dart';
import 'package:sahayatri/Helper_Classes/connectivity_helper.dart';
import 'package:sahayatri/Helper_Classes/format_datetime.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/Services/client_services/upcoming_rides.dart';
import 'package:sahayatri/services/auth.dart';
import 'package:sahayatri/services/connectivity.dart';

class ClientMainPage extends StatefulWidget {
  const ClientMainPage({Key? key}) : super(key: key);

  @override
  _ClientMainPageState createState() => _ClientMainPageState();
}

class _ClientMainPageState extends State<ClientMainPage> {
  late DateTime datePicked;
  late TimeOfDay timePicked;
  late bool internetConnection;

  @override
  void initState() {
    datePicked = DateTime.now();
    timePicked = TimeOfDay.now();
    NotificationHandler.config();
    checkConnectionStatus(context);
    displayRatingBar(context);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<UpcomingRides>(context, listen: false).getUpcomingTrips();
    });
    super.initState();
  }

  // widget for picking date
  void datePicker(BuildContext context, StateSetter setState) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: datePicked,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      // restricting the vale to be chosen from the date picker
      selectableDayPredicate: (DateTime value) =>
          value.difference(DateTime.now()).inDays < 0 ||
                  value.difference(DateTime.now()).inDays > 30
              ? false
              : true,
    );

    // changing the state of date
    if (date != null) {
      setState(() {
        datePicked = date;
      });
    }
  }

  // widget for picking time of day
  void timePicker(BuildContext context, StateSetter setState) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: timePicked,
    );

    // changing the state of time
    if (time != null) {
      setState(() {
        timePicked = time;
      });
    }
  }

  Future<void> _refresh() async {
    datePicked = DateTime.now();
    timePicked = TimeOfDay.now();
    checkConnectionStatus(context);
    Provider.of<Auth>(context, listen: false).accessUser(accessToken);
    Provider.of<UpcomingRides>(context, listen: false).getUpcomingTrips();
    return Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    return ClientScaffold(
      body: SafeArea(child: pageContent(context)),
    );
  }

  RefreshIndicator pageContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      strokeWidth: 2.0,
      color: Color.fromARGB(255, 0, 22, 41),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResuableCard(
              height: 100,
              padding: 12.0,
              content: Consumer<Connectivity>(
                builder: (context, connection, child) {
                  if (connection.internetConnection) {
                    this.internetConnection = true;
                    return Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Need to reach somewhere? ',
                              style: kTextStyle,
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              'Let us be your companion!',
                              style: kSmallTextStyle,
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          child: Lottie.asset(
                            'assets/lotties/travel.json',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    );
                  } else {
                    this.internetConnection = false;
                    return kMapLoading;
                  }
                },
              ),
              onTap: () {
                checkConnectionStatus(context);
                (this.internetConnection)
                    ? Navigator.pushNamed(context, 'clientMapPage')
                    : Navigator.pushNamed(context, 'noInternet');
              },
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconCard(
                        icon: Icons.commute_outlined,
                        onTap: () {
                          checkConnectionStatus(context);
                          (this.internetConnection)
                              ? Navigator.pushNamed(context, 'clientMapPage')
                              : Navigator.pushNamed(context, 'noInternet');
                        },
                      ),
                      Text(
                        'Travel',
                        style: kSmallTextStyle,
                      ),
                    ],
                  ),
                  kVerticalDivider,
                  Column(
                    children: [
                      IconCard(
                        icon: Icons.local_shipping_outlined,
                        onTap: () => modalSheet(context,
                            text: 'pick-up time', isParcel: true),
                      ),
                      Text(
                        'Parcel',
                        style: kSmallTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ResuableCard(
              absorb: true,
              height: 50.0,
              padding: 12.0,
              content: Row(
                children: [
                  Icon(Icons.local_taxi_outlined),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    'Where To?',
                    style: kTextStyle,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Material(
                    color: Colors.white54,
                    child: InkWell(
                      child: Row(
                        children: [
                          Text(
                            'Set ',
                            style: kTextStyle,
                          ),
                          Icon(
                            Icons.schedule_outlined,
                            size: 20.0,
                          ),
                          Icon(
                            Icons.expand_more_outlined,
                          ),
                        ],
                      ),
                      onTap: () {
                        modalSheet(context, text: 'trip', isParcel: false);
                      },
                    ),
                  ),
                ],
              ),
              onTap: () {
                checkConnectionStatus(context);
                (this.internetConnection)
                    ? Navigator.pushNamed(context, 'clientMapPage')
                    : Navigator.pushNamed(context, 'noInternet');
              },
            ),
            ResuableCard(
              height: 50,
              padding: 12.0,
              content: Row(
                children: [
                  Icon(Icons.push_pin),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    'Set Destination on Map?',
                    style: kTextStyle,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
              color: kCardColor,
              onTap: () {
                checkConnectionStatus(context);
                (this.internetConnection)
                    ? Navigator.pushNamed(context, 'clientMapPage')
                    : Navigator.pushNamed(context, 'noInternet');
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Around You',
                  style: kTextStyle,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Icon(Icons.near_me_outlined),
              ],
            ),
            ResuableCard(
              height: 200.0,
              content: Map(),
              onTap: () {
                Navigator.pushNamed(context, 'map');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> modalSheet(BuildContext context,
      {required String text, required bool isParcel}) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext timerContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(15.0),
              height: 205,
              color: kCardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Schedule Your $text',
                      style: kTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ModalButton(
                    text: 'Date:  ${formatDate(datePicked)}',
                    onPressed: () => datePicker(context, setState),
                  ),
                  ModalButton(
                    text: 'Time:  ${formatTime(context, timePicked)}',
                    onPressed: () => timePicker(context, setState),
                  ),
                  ModalButton(
                    text: 'Set pick-up Time',
                    buttonStyle: kButtonStyle,
                    buttonTextStyle: kButtonTextStyle,
                    onPressed: () {
                      //validating for the pick-up time
                      if ((formatDate(datePicked) ==
                              formatDate(DateTime.now())) &&
                          ((TimeOfDay.now().hour) >= (timePicked.hour))) {
                        displayFlash(
                            context: context,
                            text: 'Schedule for at least 1hr from now!',
                            color: kDangerColor);
                      } else {
                        checkConnectionStatus(context);
                        (this.internetConnection)
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ClientMapPage(
                                    date: datePicked,
                                    time: timePicked,
                                    isParcel: isParcel,
                                  ),
                                ),
                              )
                            : Navigator.pushNamed(context, 'noInternet');
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
