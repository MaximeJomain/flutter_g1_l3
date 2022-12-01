class Concours {

  late String name;
  late String adress;
  late String picture;
  late String date;
  late String level;
  //late Map participants;

  Concours(this.name, this.adress, this.picture, this.date, this.level);

  String get getName => name;
  set setName(String aValue) => name = aValue;
  String get getAdress => adress;
  set setAdress(String aValue) => adress = aValue;
  String get getPicture => picture;
  set SetPicture(String aValue) => picture = aValue;
  String get getDate => date;
  set SetDate(String aValue) => date = aValue;
  String get getLevel => level;
  set SetLevel(String aValue) => level = aValue;

}