import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/main.dart';
import 'package:flutter_g1_l3/tables/tableUser.dart';
import 'package:flutter_g1_l3/view/actualites.dart';

class LoginPage extends StatefulWidget {
  static const tag = "login_page";

  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<User> usersList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<List<User>> isFindUser() async {
    List result = await MyApp.myDB.getCollection("users");
    for (var item in result) {
      final user = User(item['username'], item['password'], item['picture'],
          item['email'], item['phone'], item['old'], item['type']);
      usersList.add(user);
    }
    return usersList;
  }

  checkUsers() {
    for (var e in usersList) {
      if (e.username == usernameController.text &&
          e.password == passwordController.text) {
        Navigator.of(context).pushNamed(ActualitePage.tag);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'username',
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                     await isFindUser();
                      checkUsers();
                    },
                    child: const Text('Submit'),
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
