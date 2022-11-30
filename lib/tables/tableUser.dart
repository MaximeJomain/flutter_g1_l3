class User {

  late String username;
  late String password;
  late String picture;
  late BigInt phone;
  late BigInt old;
  late String type;

  User(this.username, this.password, this.picture, this.phone, this.old, this.type);

  String get getUsername => username;
  set setUsername(String aValue) => username = aValue;
  String get getPassword => password;
  set setPassword(String aValue) => password = aValue;

}