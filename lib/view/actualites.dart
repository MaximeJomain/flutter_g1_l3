import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/view/admin.dart';
import 'package:flutter_g1_l3/view/event.dart';
import 'package:flutter_g1_l3/view/concours.dart';
import 'package:flutter_g1_l3/view/cours.dart';
import 'package:flutter_g1_l3/view/user_profile.dart';

class ActualitePage extends StatefulWidget {

  static const tag = "actualite_page";

  const ActualitePage({super.key, required this.title});

  final String title;

  @override
  State<ActualitePage> createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {

  List actualiteList = [];

  Widget _isAdmin({required String type}){
    if (type == "admin") {
      return IconButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pushNamed(AdminPage.tag),
          icon: const Icon(Icons.lock));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {

    String userType = ModalRoute.of(context)!.settings.arguments as String;

    print(userType);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pushNamed(EventPage.tag),
                  icon: const Icon(Icons.event)),
              IconButton(
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pushNamed(ConcoursPage.tag),
                  icon: const Icon(Icons.stars)),
              IconButton(
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pushNamed(CoursPage.tag),
                  icon: const Icon(Icons.book)),
              IconButton(
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pushNamed(UserProfile.tag),
                  icon: const Icon(Icons.edit)),
              _isAdmin(type: userType),
            ],
          )
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'page actualites in progress',
            ),
          ],
        ),
      ),
    );
  }
}