import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:sahayatri/Events/event_handler.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/Services/client_services/payment_service.dart';
import 'package:sahayatri/Services/client_services/provide_rating.dart';
import 'package:sahayatri/Services/client_services/upcoming_rides.dart';

EventHandler eventHandler = new EventHandler();
late Channel clientChannel;

void enableClientChannels({required int id, required String token}) {
  eventHandler.initializeEvents(token: token);
  clientChannel = eventHandler.pusher.subscribe('private-client.$id');

  clientChannel.bind('cancel-request', (event) {
    //decoding the received json data
    dynamic decodedData = jsonDecode(event!.data!);
    NotificationHandler.displayNotificaiton(
        title: 'Request Cancelled',
        body:
            'Your request with ${decodedData[0]} has been terminated.\nTry again with other Drivers.');
  });

  clientChannel.bind('notify-client', (event) {
    //decoding the received json data
    dynamic decodedData = jsonDecode(event!.data!);
    //for displaying the notification
    NotificationHandler.displayNotificaiton(
        title: 'About to Pick-up', body: '${decodedData[0]}');
  });
}

void displayEvents(BuildContext context) {
  clientChannel.bind('confirm-request', (event) {
    //decoding the received json data
    dynamic decodedData = jsonDecode(event!.data!);
    //for displaying the notification
    NotificationHandler.displayNotificaiton(
        title: 'Request Confirmed',
        body:
            'Your ride with ${decodedData[0]} has been scheduled.\nProceed Payment?');
    //for displaying the payment dialog once ride confirmed
    Provider.of<PaymentService>(context, listen: false).proceedPayment(
        rideId: decodedData[1], amount: double.parse(decodedData[2]));
  });

  clientChannel.bind('ride-completed', (event) {
    //decoding the received json data
    dynamic decodedData = jsonDecode(event!.data!);

    NotificationHandler.displayNotificaiton(
        title: 'Ride Completed',
        body: 'Your ride with ${decodedData[0]} has been completed.');
    //passing driver ID from event, to provide rating
    Provider.of<ProvideRating>(context, listen: false)
        .provideRating(driverId: int.parse(decodedData[1]));

    //reloading the list of upcoming trips
    Provider.of<UpcomingRides>(context, listen: false).getUpcomingTrips();
  });
}

void disableClientChannels({required int id}) {
  clientChannel.unbind('confirm-request');
  clientChannel.unbind('cancel-request');
  clientChannel.unbind('ride-completed');
  eventHandler.pusher.unsubscribe('private-client.$id');
}
