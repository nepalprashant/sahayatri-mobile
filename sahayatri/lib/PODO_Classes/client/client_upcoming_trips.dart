import 'dart:convert';

//parsing json to the object of type ClientUpcomingTrips
List<ClientUpcomingTrips> clientUpcomingTripsFromJson(String details) =>
    List<ClientUpcomingTrips>.from(
        json.decode(details).map((x) => ClientUpcomingTrips.fromJson(x)));

class ClientUpcomingTrips {
  ClientUpcomingTrips({
    required this.id,
    required this.rideType,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.totalFare,
    required this.status,
    required this.payment,
    required this.driver,
    required this.location,
  });

  final int id;
  final String rideType;
  final DateTime scheduledDate;
  final String scheduledTime;
  final String totalFare;
  final String status;
  final String payment;
  final Driver driver;
  final Location location;

  factory ClientUpcomingTrips.fromJson(Map<String, dynamic> json) =>
      ClientUpcomingTrips(
        id: json["id"],
        rideType: json["ride_type"],
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        scheduledTime: json["scheduled_time"],
        totalFare: json["total_fare"],
        status: json["status"],
        payment: json["payment"] == null ? 'unpaid' : 'paid',
        driver: Driver.fromJson(json["driver"]),
        location: Location.fromJson(json["location"]),
      );
}

class Driver {
  Driver({
    required this.user,
  });

  final User user;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        user: User.fromJson(json["user"]),
      );
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.avgRating,
  });

  final int id;
  final String name;
  final String email;
  final String phoneNo;
  final double avgRating;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        avgRating: json["avg_rating"].toDouble(),
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
