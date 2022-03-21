import 'package:pusher_client/pusher_client.dart';
import 'package:sahayatri/Events/event_handler.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';

EventHandler eventHandler = new EventHandler();
late Channel clientChannel;

void enableClientChannels({required int id, required String token}) {
  eventHandler.initializeEvents(token: token);
  clientChannel = eventHandler.pusher.subscribe('private-client.$id');

  clientChannel.bind('confirm-request', (event) {
    NotificationHandler.displayNotificaiton(
        title: event!.data, body: 'something...something');
  });

  clientChannel.bind('cancel-request', (event) {
    NotificationHandler.displayNotificaiton(
        title: event!.data, body: 'something...something');
  });

  clientChannel.bind('ride-completed', (event) {
    NotificationHandler.displayNotificaiton(
        title: event!.data, body: 'something...something');
  });
}

void disableClientChannels({required int id}) {
  clientChannel.unbind('confirm-request');
  clientChannel.unbind('cancel-request');
  clientChannel.unbind('ride-completed');
  eventHandler.pusher.unsubscribe('private-client.$id');
}
