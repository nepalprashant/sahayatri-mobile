import 'dart:convert';

//converting json to RideHistory type
List<RideHistory> rideHistoryFromJson(String details) => List<RideHistory>.from(
    json.decode(details).map((x) => RideHistory.fromJson(x)));

class RideHistory {
  RideHistory({
    required this.rideType,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.totalFare,
    required this.status,
    required this.location,
  });

  final String rideType;
  final DateTime scheduledDate;
  final String scheduledTime;
  final String totalFare;
  final String status;
  final Location location;

  factory RideHistory.fromJson(Map<String, dynamic> json) => RideHistory(
        rideType: json["ride_type"],
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        scheduledTime: json["scheduled_time"],
        totalFare: json["total_fare"],
        status: json["status"],
        location: Location.fromJson(json["location"]),
      );
}

class Location {
  Location({
    required this.origin,
    required this.destination,
    required this.totalDistance,
  });

  final String origin;
  final String destination;
  final String totalDistance;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        origin: json["origin"],
        destination: json["destination"],
        totalDistance: json["total_distance"],
      );
}
