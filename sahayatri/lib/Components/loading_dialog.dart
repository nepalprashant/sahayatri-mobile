import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
    required this.text,
    }) : super(key: key);

    final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 0, 22, 41)),
            strokeWidth: 3.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            text,
            style: kSmallTextStyle,
          )
        ],
      ),
      elevation: 24.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
