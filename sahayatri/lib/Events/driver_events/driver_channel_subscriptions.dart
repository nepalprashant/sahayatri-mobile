import 'package:pusher_client/pusher_client.dart';
import 'package:sahayatri/Events/event_handler.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';

EventHandler eventHandler = new EventHandler();
late Channel privateRideRequest;

void enableDriverChannels({required int id, required String token}) {
  eventHandler.initializeEvents(token: token);
  privateRideRequest = eventHandler.pusher.subscribe('private-driver.$id');
  driverOnline();
}

void disableDriverChannels({required int id}) {
  privateRideRequest.unbind('ride-request');
  eventHandler.pusher.unsubscribe('private-driver.$id');
}

void driverOffline() {
  privateRideRequest.unbind('ride-request');
}

void driverOnline() {
  privateRideRequest.bind('ride-request', (event) {
    NotificationHandler.displayNotificaiton(title: 'Ride Request', body: event!.data);
  });
}
