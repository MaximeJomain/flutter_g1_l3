import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/main.dart';
import 'package:flutter_g1_l3/tables/tableUser.dart';
import 'package:flutter_g1_l3/view/actualites.dart';

class UserProfile extends StatefulWidget {
  static const tag = "user_profile_page";

  const UserProfile({super.key, required this.title});

  final String title;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // List<User> usersList = [];
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController ffeLinkController = TextEditingController();
  String? gender;

  // Future<List<User>> isFindUser() async {
  //   List result = await MyApp.myDB.getCollection("users");
  //   for (var item in result) {
  //     final user = User(item['username'], item['password'], item['picture'],
  //         item['email'], item['phone'], item['old'], item['type']);
  //     usersList.add(user);
  //   }
  //   return usersList;
  // }

  // checkUsers() {
  //   for (var e in usersList) {
  //     if (e.username == usernameController.text &&
  //         e.password == passwordController.text) {
  //       Navigator.of(context).pushNamed(ActualitePage.tag);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
                  Divider(),
                  Column(
                    children: [
                      RadioListTile(
                        title: Text("Demi-Pension"),
                        value: "dp",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Propriétaire"),
                        value: "owner",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {},
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
