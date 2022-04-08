import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static final _notification = FlutterLocalNotificationsPlugin();

  //configuring the initial settings for the handling the Notification
  static void config() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    _notification.initialize(initializationSettings);
  }

  static Future displayNotificaiton({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _details(),
        payload: payload,
      );

  static Future _details() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        styleInformation: BigTextStyleInformation(''),
      ),
    );
  }
}
