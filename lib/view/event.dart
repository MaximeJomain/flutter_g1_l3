import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/database.dart';
import 'package:flutter_g1_l3/main.dart';
import 'package:flutter_g1_l3/tables/tableEvent.dart';

class EventPage extends StatefulWidget {
  static const tag = "event_page";

  const EventPage({super.key, required this.title});

  final String title;

  @override
  State<EventPage> createState() => _EventPageState();
}

enum EventName { dancefloor, jeux, repas }

class _EventPageState extends State<EventPage> {
  List<Event> eventList = [];

  Future<List<Event>> isFindEvent() async {
    List<Event> eventList = [];
    final result = await MyApp.myDB.getCollection("event");
    for (var item in result) {
      final event = Event(item['type'], item['validate']);
      eventList.add(event);
    }
    return eventList;
  }

  @override
  void initState() {
    isFindEvent();
    super.initState();
  }

  EventName? event = EventName.dancefloor;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: isFindEvent(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, index)  {
                  var theme = snapshot.data?[index].getType.substring(10);
                  return Card(
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                                ),
                                child: Image.asset("assets/images/jeux.jpeg",
                                  height: 120,
                                  width: 120)
                              ),
                              Column(
                                  children: [
                                    Padding(padding: EdgeInsets.all(5),
                                      child: Text(theme!,
                                      style: const TextStyle(fontWeight: FontWeight.bold))),
                                    const Padding(padding: EdgeInsets.all(5),
                                        child: Text("Nombre de participants: ?")),
                              ])
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
         FloatingActionButton(
             onPressed: () {
              isFindEvent();
        },
           tooltip: "refresh list",
           backgroundColor: Colors.purple,
           child: const Icon(Icons.refresh),
      ),
      FloatingActionButton(
        onPressed: ()  {
          showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Indiquez le type de soirée voulu"),
            content: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('dancefloor'),
                    leading: Radio<EventName>(
                      value: EventName.dancefloor,
                      groupValue: event,
                      onChanged: (EventName? value) {
                        setState(() {
                          event = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('jeux'),
                    leading: Radio<EventName>(
                      value: EventName.jeux,
                      groupValue: event,
                      onChanged: (EventName? value) {
                        setState(() {
                          event = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('repas'),
                    leading: Radio<EventName>(
                      value: EventName.repas,
                      groupValue: event,
                      onChanged: (EventName? value) {
                        setState(() {
                          event = value;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Database.instance
                            .createEvent("event", Event("${event}", false));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("La demande d'évent a bien été envoyé")),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
          );
        },
        tooltip: 'Ajouter un event',
        child: const Icon(Icons.add),
      ),
    ],
    ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


