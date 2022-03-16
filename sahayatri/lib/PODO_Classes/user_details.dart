class User {
  int id;
  String userName;
  String email;
  String phone;

  User({required this.id, required this.userName, required this.email, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['name'],
      email: json['email'],
      phone: json['phone_no'],
    );
  }
}
