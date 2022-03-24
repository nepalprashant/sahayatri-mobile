import 'package:flutter/material.dart';
import 'package:sahayatri/Components/modal_button.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

late List<DriveHistory> _chartData;
late TooltipBehavior _tooltipBehavior;

class IncomePage extends StatelessWidget {
  const IncomePage({Key? key}) : super(key: key);

  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  Future<void> _refresh() async {
    initState();
    return Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return RefreshIndicator(
      onRefresh: _refresh,
      strokeWidth: 2.0,
      displacement: 100.0,
      color: Color.fromARGB(255, 0, 22, 41),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 50.0),
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
                        '\Rs. 2,700',
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
                            '\Rs. 2,700',
                            style: kTextStyle,
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            '\Rs. 2,250',
                            style: kSmallTextStyle,
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            '\Rs. 450',
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
      ),
    );
  }
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
        labelFormat: '\Rs.{value}',
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
