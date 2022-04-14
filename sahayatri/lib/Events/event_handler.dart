import 'dart:developer';
import 'package:pusher_client/pusher_client.dart';

class EventHandler {
  late PusherClient pusher;

  //for connecting with the pusher channel
  void initializeEvents({required String token}) {
    //backend credentials for establishing the connection
    var options = PusherOptions(
      host: 'http://sahayatri-env.eba-86dga554.ap-south-1.elasticbeanstalk.com',
      wsPort: 433,
      cluster: 'ap2',
      encrypted: true,
      auth: PusherAuth(
        'http://sahayatri-env.eba-86dga554.ap-south-1.elasticbeanstalk.com/api/broadcasting/auth',
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

      //display error in the console
      pusher.onConnectionError((error) {
        log("error: ${error!.message}");
      });
    } catch (e) {
      print("Error Connecting to Pusher");
    }
  }
}
