import 'package:flutter/material.dart';
import 'package:sahayatri/Components/icon_card.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconCard(
      icon: icon,
      cardColor: Colors.white,
      height: 75,
      width: 75,
      iconSize: 32,
      iconColor: Colors.blueGrey.shade800,
      onTap: onTap,
    );
  }
}
