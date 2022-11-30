import 'package:flutter_g1_l3/main.dart';

class User {

  late String username;
  late String password;

  User(this.username, this.password);

  String get getUsername => username;
  set setUsername(String aValue) => username = aValue;
  String get getPassword => password;
  set setPassword(String aValue) => password = aValue;

}