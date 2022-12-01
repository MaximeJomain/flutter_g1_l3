import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/database.dart';
import 'package:flutter_g1_l3/main.dart';
import 'package:flutter_g1_l3/tables/tableUser.dart';
import 'package:get_storage/get_storage.dart';

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

  List<bool?> _isChecked = [];
  String username = "user1";
  List<Horse> horsesList = [];
  List<String> selectedHorses = [];
  String? _type;
  String? _horseName;

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController ffeLinkController = TextEditingController();

  Future<List<Horse>> getHorsesList() async {
    List result = await MyApp.myDB.getCollection("horses");
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
              child: const Text('Approve'),
              onPressed: () {
                MyApp.myDB.updateHorseOwner(username, horseName);
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
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
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
                  ),
                  TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Age',
                    ),
                  ),
                  TextFormField(
                    controller: ffeLinkController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Lien FFE',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(12.0)),
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
                            _isChecked = List<bool>.filled(horsesList.length, false);
                          }
                          _ownerDialog();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        MyApp.myDB.updateUserInfo(
                            username, phoneNumberController.text,
                            ageController.text, ffeLinkController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(
                                'Vos informations on bien été modifiées')));
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
