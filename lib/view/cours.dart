import 'package:flutter/material.dart';

class CoursPage extends StatefulWidget {

  static const tag = "cours_page";

  const CoursPage({super.key, required this.title});

  final String title;

  @override
  State<CoursPage> createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {

  List coursList = [];

  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: coursList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.stars,
                                color: Colors.green,
                                size: 30.0,
                              ),
                              Column(children: [
                                Text(coursList[index].getType),
                                Text(coursList[index].getPhoto),
                              ])
                            ],
                          ),
                          Text(coursList[index].getParticipants),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'faire une demande de cours',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}