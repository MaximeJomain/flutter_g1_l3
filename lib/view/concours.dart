import 'package:flutter/material.dart';

class ConcoursPage extends StatefulWidget {

  static const tag = "concours_page";

  const ConcoursPage({super.key, required this.title});

  final String title;

  @override
  State<ConcoursPage> createState() => _ConcoursPageState();
}

class _ConcoursPageState extends State<ConcoursPage> {

  List concoursList = [];

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
                itemCount: concoursList.length,
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
                                Text(concoursList[index].getType),
                                Text(
                                  concoursList[index].getPhoto,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                              ])
                            ],
                          ),
                          Text(concoursList[index].getParticipants),
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
        tooltip: 'Ajouter un concours',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}