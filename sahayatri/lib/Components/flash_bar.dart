import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';

Future<Object?> displayFlash({
  required BuildContext context,
  required String text,
  Color? color,
  bool? displayIcon,
  IconData? icon,
}) {
  return showFlash(
    context: context,
    duration: const Duration(seconds: 3),
    builder: (context, controller) {
      return Flash(
        controller: controller,
        behavior: FlashBehavior.floating,
        position: FlashPosition.bottom,
        backgroundColor: (color ?? Colors.black).withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        margin: EdgeInsets.only(bottom: 75.0, right: 50, left: 50),
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          content: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  (displayIcon ?? true)
                      ? (icon ?? Icons.warning_amber_outlined)
                      : null,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  text,
                  style: kTextStyleWhite,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
