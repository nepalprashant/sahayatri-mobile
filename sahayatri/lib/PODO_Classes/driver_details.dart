class DriverDetails{
  String name;
  String rating;
  String phone;
  String vehicle;
  String rate;

  DriverDetails({required this.name, required this.rating, required this.phone, required this.vehicle, required this.rate});

  factory DriverDetails.fromJson(Map<String, dynamic> json){
    return DriverDetails(
      name: json['name'], 
      rating: json['rating'], 
      phone: json['phone_no'], 
      vehicle: json['vehicle_type'], 
      rate: json['fare_rate'],
      );
  }
}