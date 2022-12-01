import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/main.dart';
import 'package:flutter_g1_l3/tables/tableUser.dart';
import 'package:flutter_g1_l3/view/actualites.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class LoginPage extends StatefulWidget {

  static const tag = "login_page";

  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<User> usersList = [];
  Future<List<User>> isFindUser() async {
    List result = await MyApp.myDB.getCollection("users");
    for (var item in result) {
      final user = User(item['username'], item['password'], item['picture'], item['phone'], item['old'], item['type']);
      usersList.add(user);
    }
    return usersList;
  }

  checkUsers() {
    for (var user in usersList) {
      if(user.username == usernameController.text &&
          user.password == passwordController.text) {
        print("user connected");
        Navigator.of(context).pushNamed(ActualitePage.tag);
    } else {print("error");}
    }
    }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                    onPressed: () {
                      isFindUser();
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
