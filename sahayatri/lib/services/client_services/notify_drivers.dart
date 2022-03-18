import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';
import 'package:sahayatri/services/dio_services.dart';

Map rideDetails = {};

void notifyDriver({
  required int driverId,
  required double initialLat,
  required double initialLng,
  required double destinationLat,
  required double destinationLng,
  required String origin,
  required String destination,
  required double totalDistance,
  required double totalFare,
  required String? rideType,
  TimeOfDay? scheduledTime,
  DateTime? scheduledDay,
}) async {
  rideDetails.addAll({
    'driver_id': driverId,
    'client_id': userId,
    'initial_lat': initialLat,
    'initial_lng': initialLng,
    'destination_lat': destinationLat,
    'destination_lng': destinationLng,
    'origin': origin,
    'destinaiton': destination,
    'total_distance': totalDistance,
    'total_fare': totalFare,
    'ride_type': rideType ?? 'intercity',
    'scheduled_time': scheduledTime ?? null,
    'scheduled_day': scheduledDay ?? null,
  });

  try {
    Dio.Response response = await dio().post('/request/driver',
        data: rideDetails,
        options: Dio.Options(headers: {
          'Authorization': 'Bearer $accessToken'
        })); //fetching information
    rideDetails.clear();
    //displaying the notification
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
