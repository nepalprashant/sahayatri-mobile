import 'package:flutter/material.dart';
import 'package:sahayatri/Components/request_detail.dart';
import 'package:sahayatri/Constants/constants.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 60.0),
      child: Center(
          child: Column(
            children: [
              Text('Ride Requests', style: kTextStyle,),
              SizedBox(height: 15.0),
              RequestCard(),
            ],
          ),
      ),
    );
  }
}
