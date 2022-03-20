import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:sahayatri/Events/event_handler.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/Services/driver_services/driver_availability.dart';
import 'package:sahayatri/Services/driver_services/received_request.dart';

EventHandler eventHandler = new EventHandler();
late Channel privateRideRequest;

void enableDriverChannels({required int id, required String token}) {
  eventHandler.initializeEvents(token: token);
  privateRideRequest = eventHandler.pusher.subscribe('private-driver.$id');
}

void disableDriverChannels({required int id}) {
  privateRideRequest.unbind('ride-request');
  eventHandler.pusher.unsubscribe('private-driver.$id');
}

void driverOffline() {
  privateRideRequest.unbind('ride-request');
}

void driverOnline(BuildContext context) {
  privateRideRequest.bind('ride-request', (event) {
    NotificationHandler.displayNotificaiton(
        title: 'Ride Request', body: 'You have a new request!');
    Provider.of<ReceivedRequest>(context, listen: false).requestDetails(event!.data);
  });
}
