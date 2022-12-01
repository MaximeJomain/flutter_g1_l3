class User {

  late String username;
  late String password;
  late String picture;
  late String email;
  late String phone;
  late String old;
  late String type;

  User(this.username, this.password, this.picture, this.email, this.phone, this.old, this.type);

  String get getUsername => username;
  set setUsername(String aValue) => username = aValue;
  String get getPassword => password;
  set setPassword(String aValue) => password = aValue;
  String get getEmail => email;
  set SetEmail(String aValue) => email = aValue;
  String get getPicture => picture;
  set SetPicture(String aValue) => picture = aValue;

}