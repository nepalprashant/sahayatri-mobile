import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({
    Key? key,
    this.pageLoading,
  }) : super(key: key);

  final bool? pageLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (pageLoading ?? false) ? kLoading : kNoInternet,
    );
  }
}
