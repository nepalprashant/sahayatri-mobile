import 'package:flutter/material.dart';

class BottomLoginText extends StatelessWidget {
  const BottomLoginText({
    Key? key,
    required this.mainText,
    required this.linkText,
    required this.onPressed,
    this.icon,
    this.displayIcon,
  }) : super(key: key);

  final String mainText;
  final String linkText;
  final Function() onPressed;
  final IconData? icon;
  final bool? displayIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(mainText),
        InkWell(
          child: Row(
            children: [
              Text(
                linkText,
                style: TextStyle(color: Colors.blue),
              ),
              Icon(
                (displayIcon ?? true ) ? (icon ?? Icons.arrow_forward_outlined) : null,
                color: Colors.blue,
                size: 18.0,
              )
            ],
          ),
          onTap: onPressed,
        ),
      ],
    );
  }
}
