class User {
  int id;
  String userName;
  String email;
  String phone;
  double rating;

  User(
      {required this.id,
      required this.userName,
      required this.email,
      required this.phone,
      required this.rating});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['name'],
      email: json['email'],
      phone: json['phone_no'],
      rating: json['rating_avg_rating'].toDouble(),
    );
  }
}
