import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Components/loading_dialog.dart';
import 'package:sahayatri/Components/rating_bar.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Driver/income_page.dart';
import 'package:sahayatri/Driver/request_page.dart';
import 'package:sahayatri/Driver/setting_page.dart';
import 'package:sahayatri/Events/driver_events/driver_channel_subscriptions.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/Services/driver_services/driver_availability.dart';
import 'package:sahayatri/Services/driver_services/received_request.dart';
import 'package:sahayatri/screens/map_page.dart';
import 'package:flutter_switch/flutter_switch.dart';

enum IconMenu {
  home,
  explore,
  bar,
  setting,
}

class DriverMainPage extends StatefulWidget {
  const DriverMainPage({Key? key}) : super(key: key);

  @override
  _DriverMainPageState createState() => _DriverMainPageState();
}

class _DriverMainPageState extends State<DriverMainPage> {
  IconMenu selectedIcon = IconMenu.home;
  bool status = false;

  @override
  void initState() {
    NotificationHandler.config();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child:
        Consumer<ChangeAvailability>(builder: (context, availability, child) {
      return Scaffold(
        appBar: (selectedIcon == IconMenu.home)
            ? AppBar(
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                  ),
                  child: CircleAvatar(
                    child: Lottie.asset('assets/lotties/avatar.json'),
                    backgroundColor: kCardColor,
                    radius: 20.0,
                  ),
                ),
                centerTitle: true,
                title: FlutterSwitch(
                  width: 80,
                  height: 28,
                  padding: 1.0,
                  toggleSize: 25,
                  valueFontSize: 14.0,
                  activeColor: Colors.lightBlue,
                  activeTextColor: Colors.white,
                  inactiveColor: Colors.black45,
                  inactiveTextColor: Colors.white,
                  value: status,
                  activeText: 'Online',
                  inactiveText: 'Offline',
                  activeIcon: Lottie.asset('assets/lotties/twitter.json'),
                  inactiveIcon: Lottie.asset('assets/lotties/twitter.json'),
                  showOnOff: true,
                  onToggle: (value) {
                    if (!status) {
                      Provider.of<ChangeAvailability>(context, listen: false)
                          .online();
                    } else {
                      Provider.of<ChangeAvailability>(context, listen: false)
                          .offline();
                    }
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(ctx);
                          if (availability.isOnline) {
                            driverOnline(context);
                            setState(() {
                              status = value;
                            });
                            displayFlash(
                                context: context,
                                text: 'You\'re now Online',
                                icon: Icons.info_outline);
                          } else if (availability.isOffline) {
                            driverOffline();
                            setState(() {
                              status = value;
                            });
                            displayFlash(
                                context: context,
                                text: 'You\'re Offline',
                                icon: Icons.info_outline);
                          } else {
                            displayFlash(
                                context: context,
                                text: 'Can\'t connect to the server',
                                color: Color.fromARGB(255, 134, 10, 1));
                          }
                        });
                        return LoadingDialog(text: 'Changing the availability');
                      },
                      barrierDismissible: false,
                    );
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () => {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          // Future.delayed(const Duration(seconds: 2), () {
                          //   Navigator.pop(ctx);
                          // });
                          return Rating();
                        },
                        barrierDismissible: true,
                      ),
                    },
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.black87,
                      size: 30,
                    ),
                  ),
                ],
              )
            : null,
        backgroundColor: Color(0xFFDFE8E9),
        body: (() {
          if (selectedIcon == IconMenu.home) {
            //driver main page
            return Center(
              child: MapPage(),
            );
          } else if (selectedIcon == IconMenu.explore) {
            return RequestPage();
          } else if (selectedIcon == IconMenu.bar) {
            //driver income page
            return IncomePage();
          } else {
            //driver setting page
            return SettingPage();
          }
        }()),
        //Navigation bar
        bottomNavigationBar: Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 30.0,
                    color: (selectedIcon == IconMenu.home)
                        ? kActiveColor
                        : kInactiveColor,
                  ),
                  onPressed: () => setState(() {
                    selectedIcon = IconMenu.home;
                  }),
                ),
                IconButton(
                  icon: Icon(
                    Icons.explore_outlined,
                    size: 30.0,
                    color: (selectedIcon == IconMenu.explore)
                        ? kActiveColor
                        : kInactiveColor,
                  ),
                  onPressed: () => setState(() {
                    selectedIcon = IconMenu.explore;
                  }),
                ),
                IconButton(
                  icon: Icon(
                    Icons.bar_chart_outlined,
                    size: 30.0,
                    color: (selectedIcon == IconMenu.bar)
                        ? kActiveColor
                        : kInactiveColor,
                  ),
                  onPressed: () => setState(() {
                    selectedIcon = IconMenu.bar;
                  }),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    size: 30.0,
                    color: (selectedIcon == IconMenu.setting)
                        ? kActiveColor
                        : kInactiveColor,
                  ),
                  onPressed: () => setState(() {
                    selectedIcon = IconMenu.setting;
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
