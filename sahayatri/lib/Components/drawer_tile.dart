import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black87,
      ),
      title: Text(
        text,
        style: kSmallTextStyle,
      ),
      onTap: onTap,
    );
  }
}
