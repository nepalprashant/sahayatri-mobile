import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/services/connectivity.dart';

void checkConnectionStatus(BuildContext context) {
  Provider.of<Connectivity>(
    context,
    listen: false,
  ).connectionStatus();
}
