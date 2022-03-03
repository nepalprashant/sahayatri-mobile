import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificaitonHandler {
  static final _notification = FlutterLocalNotificationsPlugin();

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
      ),
    );
  }
}
