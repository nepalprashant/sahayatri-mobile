import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';

class ModalButton extends StatelessWidget {
  const ModalButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonStyle,
    this.buttonTextStyle,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: buttonStyle ??
          ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kCardColor),
          ),
      child: Text(
        text,
        style: buttonTextStyle ?? kTextStyle,
      ),
      onPressed: onPressed,
    );
  }
}
