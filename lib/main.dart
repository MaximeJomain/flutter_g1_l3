import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/database/database.dart';
import 'package:flutter_g1_l3/sign_up.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  // await MongoDatabase.connect();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final myDB = Database("test", "test", "cluster0.qhfwu3w.mongodb.net", "test");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      /*routes: {
        LoginPage.tag : (context)=>const LoginPage(title: "login")
      },*/
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MySignupPage(title: "Page d'inscription"),
    );
  }
}


