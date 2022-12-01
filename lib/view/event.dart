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

  // Future<List<Event>> isFindEvent() async {
  //   print("fonction ok");
  //     final result = await MyApp.myDB.getCollection("event");
  //     print(result);
  //     for (var item in result) {
  //       final event = Event(item['type'], item['validate']);
  //       eventList.add(event);
  //     }
  //   print(eventList);
  //   return eventList;
  // }

  Future<List<Event>> isFindEvent() async {
    List<Event> eventList = []; // la variable que tu dois créer
    print("fonction ok");
    final result = await MyApp.myDB.getCollection("event");
    print(result);
    for (var item in result) {
      final event = Event(item['type'], item['validate']);
      eventList.add(event); // ici tu remplace par la variable
    }
    print(eventList);
    return eventList; // et ici tu renvoies la variable
  }

  // @override
  // void initState() {
  //   print(eventList);
  //   super.initState();
  // }

  EventName? event = EventName.dancefloor;
  // EventName? _event = event.substring(10);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController commentairesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: isFindEvent(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) { // ici tu vérifie si tu recois bien de la donnée
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, index) {
                  return Text("${snapshot.data?[index].getType}");
                });
            return Container(); // pour le moment retourne juste un container vide
          } else if (snapshot.hasError) { // ici s'il y a une erreur
            print(snapshot.error);
            return Container();
          } else {
            // Et ici s'il n y a pas encore de la donnée tu retourne quelque chose
            return Container();
          }
        },
      ),
      floatingActionButton: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
         FloatingActionButton(
             onPressed: () {
              // _isFindEvent();
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


