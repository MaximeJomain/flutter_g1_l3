class Event {

  late String type;
       bool validate;

  Event(this.type,
      this.validate);

  String get getType => type;
  set setType(String aValue) => type = aValue;
  bool get getValidate => validate;
  set setValidate(bool aValue) => validate = true;
}