import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';

class ResuableCard extends StatelessWidget {
  const ResuableCard({
    Key? key,
    required this.height,
    required this.content,
    required this.onTap,
    this.color,
    this.padding,
    this.align,
    this.width,
    this.absorb,
    this.disableTouch,
    this.disableSplashColor,
  }) : super(key: key);

  final double height;
  final Widget content;
  final Function() onTap;
  final Color? color;
  final double? padding;
  final Alignment? align;
  final double? width;
  final bool? absorb;
  final bool? disableTouch;
  final bool? disableSplashColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: (disableTouch ?? false)
          ? AbsorbPointer(
              child: inkwellContent(),
            )
          : inkwellContent(),
      color: color ?? kCardColor,
      margin: EdgeInsets.all(12.0),
      elevation: 8,
      shadowColor: Colors.grey.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  InkWell inkwellContent() {
    return InkWell(
      onTap: onTap,
      splashColor:
          (disableSplashColor ?? false) ? Colors.white : Colors.blueGrey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(padding ?? 0),
            alignment: align ?? Alignment.centerLeft,
            width: width,
            height: height,
            //absorbing pointer from the whole card
            child: (absorb ?? false)
                ? content
                : AbsorbPointer(
                    child: content,
                  ),
          ),
        ],
      ),
    );
  }
}
