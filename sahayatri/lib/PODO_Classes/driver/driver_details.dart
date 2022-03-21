import 'dart:convert';

//this method converts the json to the DriverDetails type
List<DriverDetails> driverDetailsFromJson(String details) =>
    List<DriverDetails>.from(
        json.decode(details).map((x) => DriverDetails.fromJson(x)));

class DriverDetails {
  DriverDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.ratingAvgRating,
    required this.driver,
  });

  int id;
  String name;
  String email;
  String phoneNo;
  double ratingAvgRating;
  Driver driver;

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        ratingAvgRating: json["rating_avg_rating"].toDouble(),
        driver: Driver.fromJson(json["driver"]),
      );
}

class Driver {
  Driver({
    required this.vehicle,
  });

  Vehicle vehicle;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        vehicle: Vehicle.fromJson(json["vehicle"]),
      );
}

class Vehicle {
  Vehicle({
    required this.vehicleType,
  });
  VehicleType vehicleType;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        vehicleType: VehicleType.fromJson(json["vehicle_type"]),
      );
}

class VehicleType {
  VehicleType({
    required this.vehicleType,
    required this.fareRate,
  });

  String vehicleType;
  String fareRate;

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
        vehicleType: json["vehicle_type"],
        fareRate: json["fare_rate"],
      );
}
