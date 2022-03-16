import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/services/dio_services.dart';

void notifyDriver({required int driverId}) async {
  Map details = {
    'driver_id': driverId,
    'client_id': userId,
  };

  try {
    Dio.Response response = await dio().post('/request/driver',
        data: details,
        options: Dio.Options(headers: {
          'Authorization': 'Bearer $accessToken'
        })); //fetching information

    Future.delayed(const Duration(seconds: 4), () {
      NotificationHandler.displayNotificaiton(
          title: "Request Forwarded",
          body:
              "Your request has been forwarded to the driver. \nYou'll be notified shortly.");
    });
    print(response.data);
  } catch (e) {
    Future.delayed(const Duration(seconds: 1), () {
      NotificationHandler.displayNotificaiton(
          title: "Connection Error", body: "Can't connect to the server!");
    });
  }
}
