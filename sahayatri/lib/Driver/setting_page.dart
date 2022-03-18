import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Components/driver_cards.dart';
import 'package:sahayatri/Components/legal_info.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/driver_services/driver_availability.dart';
import 'package:sahayatri/services/auth.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<Auth>(
            builder: (context, auth, child) {
              if (auth.authenticated) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auth.user.userName,
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
                                  auth.user.email,
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
                                  auth.user.phone,
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
                          (auth.user.rating != 0)
                              ? auth.user.rating.toStringAsFixed(1)
                              : 'N/A',
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
                              Provider.of<Auth>(context, listen: false)
                                  .driverLogout();
                              Provider.of<ChangeAvailability>(context,
                                      listen: false)
                                  .offline();
                            }),
                        Text(
                          'Logout',
                          style: kSmallTextStyle,
                        ),
                      ],
                    ),
                  ],
                );
              }
              return kNoInternet;
            },
          ),
        ),
      ),
    );
  }
}
