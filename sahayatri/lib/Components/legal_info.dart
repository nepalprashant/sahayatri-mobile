import 'package:flutter/material.dart';

void legalInfo(BuildContext context) {
    return showAboutDialog(
            context: context,
            applicationIcon: Image.asset(
              'assets/images/logo.png',
              height: 50.0,
              width: 50.0,
            ),
            applicationName: 'Saha-Yatri',
            applicationVersion: '1.0.0',
          );
  }
