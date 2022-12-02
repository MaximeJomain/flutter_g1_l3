import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {

  static const tag = "admin_page";

  const AdminPage({super.key, required this.title});

  final String title;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'page admin in progress',
            ),
          ],
        ),
      ),
    );
  }
}