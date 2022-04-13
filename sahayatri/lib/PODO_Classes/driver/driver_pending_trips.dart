import 'dart:convert';

//json list to map of type DriverPendingTrips
List<DriverPendingTrips> driverPendingTripsFromJson(String details) =>
    List<DriverPendingTrips>.from(
        json.decode(details).map((x) => DriverPendingTrips.fromJson(x)));

class DriverPendingTrips {
  DriverPendingTrips({
    required this.id,
    required this.rideType,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.totalFare,
    required this.payment,
    required this.client,
    required this.location,
  });

  final int id;
  final String rideType;
  final DateTime scheduledDate;
  final String scheduledTime;
  final String totalFare;
  final String payment;
  final Client client;
  final Location location;

  factory DriverPendingTrips.fromJson(Map<String, dynamic> json) =>
      DriverPendingTrips(
        id: json["id"],
        rideType: json["ride_type"],
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        scheduledTime: json["scheduled_time"],
        totalFare: json["total_fare"],
        payment: json["payment"] == null ? 'unpaid' : 'paid',
        client: Client.fromJson(json["client"]),
        location: Location.fromJson(json["location"]),
      );
}

class Client {
  Client({
    required this.user,
  });

  final User user;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        user: User.fromJson(json["user"]),
      );
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.rating,
  });

  final int id;
  final String name;
  final String email;
  final String phoneNo;
  final double rating;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        rating: json["avg_rating"].toDouble(),
      );
}

class Location {
  Location({
    required this.initialLat,
    required this.initialLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.origin,
    required this.destination,
    required this.totalDistance,
  });

  final String initialLat;
  final String initialLng;
  final String destinationLat;
  final String destinationLng;
  final String origin;
  final String destination;
  final String totalDistance;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        initialLat: json["initial_lat"],
        initialLng: json["initial_lng"],
        destinationLat: json["destination_lat"],
        destinationLng: json["destination_lng"],
        origin: json["origin"],
        destination: json["destination"],
        totalDistance: json["total_distance"],
      );
}
