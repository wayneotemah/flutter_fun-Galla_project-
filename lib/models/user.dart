import 'dart:async';

class User {
  User({required this.username, required this.email, required this.password});

  final username;
  final email;
  final password;

  factory User.fromJson(Map<String, String> json) {
    return User(
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }
}
