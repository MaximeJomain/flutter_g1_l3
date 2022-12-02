import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/main.dart';

import '../database.dart';
import '../tables/tableHorse.dart';

class UserProfile extends StatefulWidget {
  static const tag = "user_profile_page";

  const UserProfile({super.key, required this.title});

  final String title;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();


  List<bool?> _isChecked = [];
  String username = "user2";
  List<Horse> horsesList = [];
  List<String> selectedHorses = [];
  List<Horse> ownerHorsesList = [
    Horse("machin", null, "noir", "femelle", "saut"),
    Horse("truc", null, "bai", "male", "s aut")
  ];

  String? _type;
  String? _horseName;

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController ffeLinkController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dressController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  Future<List<Horse>> getHorsesList() async {
    List result = await Database.instance.getCollection("horses");
    if (horsesList.isEmpty) {
      for (var item in result) {
        final horse = Horse(item['name']);
        horsesList.add(horse);
      }
    }
    print(horsesList);
    return horsesList;
  }

  Future<void> _dpDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String? horseName = _horseName;
        return AlertDialog(
          title: const Text('Veuillez sélectionner votre cheval'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: horsesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RadioListTile(
                          title: Text(horsesList[index].name),
                          value: horsesList[index].name,
                          groupValue: horseName,
                          onChanged: (value) {
                            setState(() {
                              horseName = value.toString();
                              _horseName = value.toString();
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              child: const Text('Valider'),
              onPressed: () {
                Database.instance.updateHorseOwner(username, horseName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _ownerDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Veuillez sélectionner votre cheval'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: horsesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          title: Text(horsesList[index].name),
                          value: _isChecked[index],
                          onChanged: (value) {
                            setState(() {
                              _isChecked[index] = value;
                              if (_isChecked[index] == true) {
                                selectedHorses.add(horsesList[index].name);
                              } else if (_isChecked[index] == false) {
                                selectedHorses.remove(horsesList[index].name);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              child: const Text('Valider'),
              onPressed: () {
                for (var horseName in selectedHorses) {
                  Database.instance.updateHorseOwner(username, horseName);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editer le cheval'),
          content: Form(
            key: _editFormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Nom',
                  ),
                ),
                TextFormField(
                  controller: dressController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Robe',
                  ),
                ),
                TextFormField(
                  controller: sexController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Sexe',
                  ),
                ),
                TextFormField(
                  controller: specialityController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Spécialité',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Valider'),
              onPressed: () {
                for (var horseName in selectedHorses) {
                  Database.instance.updateHorseOwner(username, horseName);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(12.0)),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Numéro de téléphone',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez rentrer un numéro de téléphone";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Age',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez rentrer un âge";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: ffeLinkController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Lien FFE',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez rentrer un lien ffe";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Database.instance.updateUserInfo(
                                username,
                                phoneNumberController.text,
                                ageController.text,
                                ffeLinkController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Vos informations on bien été modifiées')));
                          }
                        },
                        child: const Text('Valider'),
                      ),
                    ),
                    const Divider(),
                    const Padding(padding: EdgeInsets.all(12.0)),
                    Column(
                      children: [
                        RadioListTile(
                          title: Text("Demi-Pension"),
                          value: "dp",
                          groupValue: _type,
                          onChanged: (value) async {
                            setState(() {
                              _type = value.toString();
                            });
                            await getHorsesList();
                            _dpDialog();
                          },
                        ),
                        RadioListTile(
                          title: Text("Propriétaire"),
                          value: "owner",
                          groupValue: _type,
                          onChanged: (value) async {
                            setState(() {
                              _type = value.toString();
                            });
                            await getHorsesList();
                            if (_isChecked.isEmpty) {
                              _isChecked =
                                  List<bool>.filled(horsesList.length, false);
                            }
                            print(selectedHorses);
                            _ownerDialog();
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    const Padding(padding: EdgeInsets.all(12.0)),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return SingleChildScrollView(
                        child: Container(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: ownerHorsesList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: const Icon(Icons.album),
                                          title:
                                              Text(ownerHorsesList[index].name),
                                          subtitle: Text(
                                              "Robe: ${ownerHorsesList[index].dress} - Sexe: ${ownerHorsesList[index].sex} - Spécialité: ${ownerHorsesList[index].speciality}"),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            TextButton(
                                              child: const Text('EDITER'),
                                              onPressed: () {
                                                _editDialog();
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
