import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/main.dart';
import 'user.dart';

class LoginPage extends StatefulWidget {

  static const tag = "login_page";

  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // checkUser() async {
  //   var db = await MongoDatabase.connect();
  //   var collection = db.collection(COLLECTION_USERS);
  //   return db;
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  void isFindUser() async  {

    setState(() {
      List result = MyApp.myDB.getCollection("users");
      result.forEach((element) {
        Map<String, dynamic> myMap = element;
        myMap.forEach((key, value) {
          if(key.contains("username")){
            if(usernameController.value == value) print("userFind");
          }
        });
        //print(element);
      });
      //Map tab = MyApp.myDB.getCollection("users");
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
