import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/database/database.dart';
import 'package:flutter_g1_l3/sign_up.dart';
import 'package:flutter_g1_l3/view/actualites.dart';
import 'package:flutter_g1_l3/database.dart';
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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
            mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pushNamed(LoginPage.tag),
                icon: const Icon(Icons.login)),
            IconButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pushNamed(ActualitePage.tag),
                icon: const Icon(Icons.home)),
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
              'page inscription in progress',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
