import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:sahayatri/Events/event_handler.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/Services/driver_services/pending_trips.dart';
import 'package:sahayatri/Services/driver_services/received_request.dart';

EventHandler eventHandler = new EventHandler();
late Channel driverChannel;

void enableDriverChannels({required int id, required String token}) {
  eventHandler.initializeEvents(token: token);
  driverChannel = eventHandler.pusher.subscribe('private-driver.$id');
}

void bindDriverChannels(BuildContext context) {
  driverChannel.bind('cancel-trip', (event) {
    //decoding the received json data
    dynamic decodedData = jsonDecode(event!.data!);
    //for displaying the notification
    NotificationHandler.displayNotificaiton(
        title: 'Trip Cancelled',
        body: 'Your ride with ${decodedData[0]} has been cancelled.');
    //reloading the list of pending trips
    Provider.of<DriverPendingRides>(context, listen: false).pendingTrips();
  });
}

void disableDriverChannels({required int id}) {
  driverChannel.unbind('ride-request');
  driverChannel.unbind('cancel-trip');
  eventHandler.pusher.unsubscribe('private-driver.$id');
}

void driverOffline() {
  driverChannel.unbind('ride-request');
}

void driverOnline(BuildContext context) {
  driverChannel.bind('ride-request', (event) {
    NotificationHandler.displayNotificaiton(
        title: 'Ride Request', body: 'You have a new request!');
    Provider.of<ReceivedRequest>(context, listen: false)
        .requestDetails(event!.data);
  });
}
