import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/main.dart';

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


  Future<void> isFindUser() async {

    setState(() {
      List result = MyApp.myDB.getCollection("users");
      for (var element in result) {
        Map<String, dynamic> myMap = element;
        myMap.forEach((key, value) {
          if(key.contains("username")){
            if(usernameController.value == value) print("userFind");
            print("nofund");
          }
        });
      }
      print("test");
    });
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
