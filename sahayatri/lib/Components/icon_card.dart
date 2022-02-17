import 'package:flutter/material.dart';
import 'package:sahayatri/Components/reusable_card.dart';
import 'package:sahayatri/Constants/constants.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    Key? key,
    required this.icon,
    required this.onTap,
    this.height,
    this.width,
    this.iconSize,
    this.cardColor,
    this.iconColor,
  }) : super(key: key);

  final IconData icon;
  final Function() onTap;
  final double? height;
  final double? width;
  final double? iconSize;
  final Color? cardColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ResuableCard(
      height: (height ?? 40.0),
      width: (width ?? 40.0),
      color: (cardColor ?? kCardColor),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            icon,
            size: (iconSize ?? 35.0),
            color: (iconColor ?? Colors.black87),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
