class Cours {

  late String land;
  late String date;
  late String schedule;
  late String duration;
  late String discipline;

  Cours(this.land, this.date, this.schedule, this.duration, this.discipline);

  String get getLand => land;
  set SetLand(String aValue) => land = aValue;
  String get getDate => date;
  set SetDate(String aValue) => date = aValue;
  String get getSchedule => schedule;
  set SetSchedule(String aValue) => schedule = aValue;
  String get getDuration => duration;
  set SetDuration(String aValue) => duration = aValue;
  String get getDiscipline => discipline;
  set SetDiscipline(String aValue) => discipline = aValue;
}