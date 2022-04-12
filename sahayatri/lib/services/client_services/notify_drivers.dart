import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/services/dio_services.dart';

Map rideDetails = {};

void notifyDriver({required int driverId, required String totalFare}) async {
  rideDetails.addAll({
    'driver_id': driverId,
    'client_id': userId,
    'total_fare': totalFare,
  });

  try {
    await dio().post('/request/driver',
        data: rideDetails,
        options: Dio.Options(headers: {
          'Authorization': 'Bearer $accessToken'
        })); //forwarding information
    rideDetails.clear();
    //displaying the notification
    Future.delayed(const Duration(seconds: 4), () {
      NotificationHandler.displayNotificaiton(
          title: "Request Forwarded",
          body:
              "Your request has been forwarded to the driver. \nYou'll be notified shortly.");
    });
  } catch (e) {
    Future.delayed(const Duration(seconds: 1), () {
      NotificationHandler.displayNotificaiton(
          title: "Connection Error", body: "Can't connect to the server!");
    });
  }
}
