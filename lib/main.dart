import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/database.dart';
import 'package:flutter_g1_l3/view/admin.dart';
import 'package:flutter_g1_l3/view/sign_up.dart';
import 'package:flutter_g1_l3/view/actualites.dart';
import 'package:flutter_g1_l3/view/login.dart';
import 'package:flutter_g1_l3/view/event.dart';
import 'package:flutter_g1_l3/view/concours.dart';
import 'package:flutter_g1_l3/view/cours.dart';
import 'package:flutter_g1_l3/view/user_profile.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        LoginPage.tag : (context) => const LoginPage(title: "login"),
        EventPage.tag : (context) => const EventPage(title: "event"),
        ConcoursPage.tag : (context) => const ConcoursPage(title: "concours"),
        CoursPage.tag : (context) => const CoursPage(title: "Cours d'équitation"),
        ActualitePage.tag : (context) => const ActualitePage(title: "actualites"),
        UserProfile.tag : (context) => const UserProfile(title: "Page de profil"),
        AdminPage.tag : (context) => const AdminPage(title: "Page admin"),
      },
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const UserProfile(title: "Page de profil"),
    );
  }
}