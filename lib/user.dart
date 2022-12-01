import 'package:flutter_g1_l3/main.dart';

class User {

  late String username;
  late String password;
  late String email;
  late String image;

  User(this.username, this.password, this.email, this.image);

  String get getUsername => username;
  set setUsername(String aValue) => username = aValue;
  String get getPassword => password;
  set setPassword(String aValue) => password = aValue;
  String get getEmail => email;
  set SetEmail(String aValue) => email = aValue;
  String get getImage => image;
  set SetImage(String aValue) => image = aValue;

}