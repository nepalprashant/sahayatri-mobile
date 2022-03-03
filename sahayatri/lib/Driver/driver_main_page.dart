import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/driver_cards.dart';
import 'package:sahayatri/Components/legal_info.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/access_token.dart';
import 'package:sahayatri/screens/map_page.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sahayatri/services/auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  IconMenu selectedIcon = IconMenu.explore;
  bool status = false;
  late List<DriveHistory> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    storedToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          (selectedIcon == IconMenu.home || selectedIcon == IconMenu.explore)
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
                    onToggle: (value) => setState(() {
                      status = value;
                    }),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => {},
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
        if (selectedIcon == IconMenu.home || selectedIcon == IconMenu.explore) {
          return Center(
            child: MapPage(),
          );
        } else if (selectedIcon == IconMenu.bar) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(top: 35.0),
            child: Column(
              children: [
                Text(
                  'My Earnings',
                  style: kHeadingTextStyle,
                ),
                ResuableCard(
                  color: Colors.white,
                  padding: 12.0,
                  height: 100.0,
                  absorb: true,
                  disableTouch: true,
                  content: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wallet Balance',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '\$2,700',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      SizedBox(
                        width: 120.0,
                        child: ModalButton(
                            text: 'Withdraw',
                            buttonStyle: kButtonStyleBlue,
                            buttonTextStyle: kButtonTextStyle,
                            onPressed: () => {}),
                      )
                    ],
                  ),
                  onTap: () {},
                ),
                ResuableCard(
                  height: 300.0,
                  absorb: true,
                  color: Colors.white,
                  disableSplashColor: true,
                  content: weeklyChart(),
                  onTap: () {},
                ),
                ResuableCard(
                  height: 155.0,
                  color: Colors.white,
                  padding: 15.0,
                  disableTouch: true,
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total Trips',
                                style: kSmallTextStyle,
                              ),
                              Text(
                                '175',
                                style: kTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Online Duration',
                                style: kSmallTextStyle,
                              ),
                              Text(
                                '5d 8h',
                                style: kTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Distance Travelled',
                                style: kSmallTextStyle,
                              ),
                              Text(
                                '200 Km',
                                style: kTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        indent: 10.0,
                        endIndent: 10.0,
                        color: Colors.black54,
                        height: 20.0,
                        thickness: 2.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Earnings',
                                style: kTextStyle,
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                'Receiveable Amount',
                                style: kSmallTextStyle,
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                'Taxes',
                                style: kSmallTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$2,700',
                                style: kTextStyle,
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                '\$2,250',
                                style: kSmallTextStyle,
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                '\$450',
                                style: kSmallTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.only(top: 30.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Hopkins',
                              style: kHeadingTextStyle,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  size: 18.0,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  'john.hopkins@gmail.com',
                                  style: kSmallTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone_outlined,
                                  size: 18.0,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '+9779814372711',
                                  style: kSmallTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 3,
                        ),
                        CircleAvatar(
                          child: Lottie.asset('assets/lotties/avatar.json'),
                          backgroundColor: Colors.white,
                          radius: 50.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.purpleAccent,
                          size: 25.0,
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Text(
                          '4.8',
                          style: kTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            DriverCard(
                              icon: Icons.support_outlined,
                              onTap: () {},
                            ),
                            Text(
                              'Support',
                              style: kSmallTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            DriverCard(
                              icon: Icons.business_center_outlined,
                              onTap: () {},
                            ),
                            Text(
                              'Wallet',
                              style: kSmallTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            DriverCard(
                              icon: Icons.local_taxi_outlined,
                              onTap: () {},
                            ),
                            Text(
                              'Trips',
                              style: kSmallTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            DriverCard(
                              icon: Icons.manage_accounts_outlined,
                              onTap: () {},
                            ),
                            Text(
                              'Update Profile',
                              style: kSmallTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            DriverCard(
                              icon: Icons.mail_outline_outlined,
                              onTap: () {},
                            ),
                            Text(
                              'Messages',
                              style: kSmallTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            DriverCard(
                              icon: Icons.info_outline,
                              onTap: () => legalInfo(context),
                            ),
                            Text(
                              'Legal',
                              style: kSmallTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Column(
                      children: [
                        DriverCard(
                            icon: Icons.logout_outlined,
                            onTap: () {
                              Provider.of<Auth>(
                                context,
                                listen: false,
                              ).driverLogout();
                            }),
                        Text(
                          'Logout',
                          style: kSmallTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }()),
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
  }

  SfCartesianChart weeklyChart() {
    return SfCartesianChart(
        // Initialize category axis
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        title: ChartTitle(
          text: 'Weekly Income Analysis',
          textStyle: kChartTitleStyle,
        ),
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: CategoryAxis(
          labelStyle: kChartLabelStyle,
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '\${value}',
          labelStyle: kChartLabelStyle,
        ),
        series: <ColumnSeries>[
          ColumnSeries<DriveHistory, String>(
              // Bind data source
              color: Colors.purpleAccent,
              isVisible: true,
              dataSource: _chartData,
              enableTooltip: true,
              name: 'Weekly Income',
              xValueMapper: (DriveHistory dh, _) => dh.week,
              yValueMapper: (DriveHistory dh, _) => dh.income),
          // dataLabelSettings: DataLabelSettings(isVisible: true)
        ]);
  }
}

List<DriveHistory> getChartData() {
  return <DriveHistory>[
    DriveHistory('Sun', 800),
    DriveHistory('Mon', 700),
    DriveHistory('Tue', 950),
    DriveHistory('Wed', 750),
    DriveHistory('Thu', 1100),
    DriveHistory('Fri', 1050),
    DriveHistory('Sat', 1400),
  ];
}

class DriveHistory {
  DriveHistory(this.week, this.income);
  final String week;
  final double income;
}
