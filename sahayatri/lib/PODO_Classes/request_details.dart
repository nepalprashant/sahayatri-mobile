import 'dart:convert';

//converting json to RequestDetails type
RequestDetails requestDetailsFromJson(String details) => RequestDetails.fromJson(json.decode(details));

class RequestDetails {
    RequestDetails({
        required this.user,
        required this.ride,
    });

    final User user;
    final Ride ride;

    factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
        user: User.fromJson(json["user"]),
        ride: Ride.fromJson(json["ride"]),
    );
}

class Ride {
    Ride({
        required this.id,
        required this.rideType,
        required this.scheduledDate,
        required this.scheduledTime,
        required this.totalFare,
        required this.location,
    });

    final int id;
    final String rideType;
    final DateTime scheduledDate;
    final String scheduledTime;
    final String totalFare;
    final Location location;

    factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        id: json["id"],
        rideType: json["ride_type"],
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        scheduledTime: json["scheduled_time"],
        totalFare: json["total_fare"],
        location: Location.fromJson(json["location"]),
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

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.phoneNo,
        required this.ratingAvgRating,
    });

    final int id;
    final String name;
    final String email;
    final String phoneNo;
    final double ratingAvgRating;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        ratingAvgRating: json["rating_avg_rating"].toDouble(),
    );
}
