import 'dart:developer';
import 'package:pusher_client/pusher_client.dart';

class EventHandler {
  late PusherClient pusher;

  void initializeEvents({required String token}) {
    var options = PusherOptions(
      host: 'http://192.168.254.57',
      wsPort: 433,
      cluster: 'ap2',
      encrypted: true,
      auth: PusherAuth(
        'http://192.168.254.57/api/broadcasting/auth',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
    );

    try {
      pusher = PusherClient(
        '88a5867cc2cf108767c9',
        options,
        enableLogging: true,
      );

      pusher.connect();

      pusher.onConnectionStateChange((state) {
        log('previousState: ${state!.previousState}, currentState: ${state.currentState}');
      });

      pusher.onConnectionError((error) {
        log("error: ${error!.message}");
      });
    } catch (e) {
      print("Error Connecting to Pusher");
    }
  }
}
