import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {

  static const tag = "event_page";

  const EventPage({super.key, required this.title});

  final String title;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

List eventList = [];

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
                itemCount: eventList.length,
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
                                Text(eventList[index].getType),
                                Text(
                                  eventList[index].getPhoto,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                              ])
                            ],
                          ),
                          Text(eventList[index].getParticipants),
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
        tooltip: 'Ajouter un event',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}