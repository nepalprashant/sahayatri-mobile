class User {
  String userName;
  String email;
  String phone;

  User({required this.userName, required this.email, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['name'],
      email: json['email'],
      phone: json['phone_no'],
    );
  }
}
