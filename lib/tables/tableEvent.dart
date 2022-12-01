class Event {

  late String type;
  // late Map participants;
  // late DateTime date;
       bool validate;

  Event(this.type,
      // this.participants,
      // this.date,
      this.validate);

  String get getType => type;
  set setType(String aValue) => type = aValue;
  bool get getValidate => validate;
  set setValidate(bool aValue) => validate = true;
}