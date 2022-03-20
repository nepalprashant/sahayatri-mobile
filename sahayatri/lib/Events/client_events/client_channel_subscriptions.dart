import 'package:pusher_client/pusher_client.dart';
import 'package:sahayatri/Events/event_handler.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';

EventHandler eventHandler = new EventHandler();
late Channel privateTest;

void enableClientChannels({required int id, required String token}) {
  eventHandler.initializeEvents(token: token);
  privateTest = eventHandler.pusher.subscribe('private-test.$id');

  privateTest.bind('test-test', (event) {
    NotificationHandler.displayNotificaiton(
        title: event!.data, body: 'something...something');
  });
}

void disableClientChannels({required int id}) {
  privateTest.unbind('test-test');
  eventHandler.pusher.unsubscribe('private-test.$id');
}
