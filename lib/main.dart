import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/database.dart';
import 'package:flutter_g1_l3/view/sign_up.dart';
import 'package:flutter_g1_l3/view/actualites.dart';
import 'package:flutter_g1_l3/view/login.dart';
import 'package:flutter_g1_l3/view/event.dart';
import 'package:flutter_g1_l3/view/concours.dart';
import 'package:flutter_g1_l3/view/cours.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final myDB = Database("test", "test", "cluster0.qhfwu3w.mongodb.net", "test");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        LoginPage.tag : (context) => const LoginPage(title: "login"),
        EventPage.tag : (context) => const EventPage(title: "event"),
        ConcoursPage.tag : (context) => const ConcoursPage(title: "concours"),
        CoursPage.tag : (context) => const ConcoursPage(title: "cours"),
        ActualitePage.tag : (context) => const ActualitePage(title: "actualites"),

      },
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MySignupPage(title: "Page d'inscription"),
    );
  }
}