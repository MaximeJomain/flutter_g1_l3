import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/main.dart';
import 'package:flutter_g1_l3/tables/tableCours.dart';
import 'package:flutter_g1_l3/database.dart';

class CoursPage extends StatefulWidget {
  static const tag = "cours_page";

  const CoursPage({super.key, required this.title});

  final String title;

  @override
  State<CoursPage> createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<Cours> coursList = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController scheduleController = TextEditingController();
  String? _land;
  String? duration;
  String? discipline;

  Future<List<Cours>> isFindCours() async {
    final result = await MyApp.myDB.getCollection("cours");
    for (var item in result) {
      final cours = Cours(item['land'], item['date'], item['schedule'],
          item['duration'], item['discipline']);
      coursList.add(cours);
    }
    return coursList;
  }

  Future<void> _formDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String? land = _land;
        return AlertDialog(
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Programmer un cours d'équitation",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          const Text(
                            "Sélectionnez le terrain d’entrainement",
                            style: TextStyle(fontSize: 13),
                          ),
                          /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [*/
                          RadioListTile(
                            title: Text("Carrière"),
                            value: "Carrière",
                            groupValue: land,
                            onChanged: (value) {
                              setState(() {
                                land = value.toString();
                                _land = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Manège"),
                            value: "Manège",
                            groupValue: land,
                            onChanged: (value) {
                              setState(() {
                                land = value.toString();
                                _land = value.toString();
                              });
                            },
                          ),
                          /*],
            ),*/
                          TextFormField(
                            controller: dateController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_month),
                              labelText: "Date de l'évenement",
                            ),
                          ),
                          TextFormField(
                            controller: scheduleController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.access_time_outlined),
                              labelText: "Heure de l'évenement",
                            ),
                          ),
                          Divider(),
                          const Text(
                            "Choisissez la durée de l'entrainement",
                            style: TextStyle(fontSize: 13),
                          ),
                          RadioListTile(
                            title: Text("30 minutes"),
                            value: "30 minutes",
                            groupValue: duration,
                            onChanged: (value) {
                              setState(() {
                                duration = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("1 heure"),
                            value: "1 heure",
                            groupValue: duration,
                            onChanged: (value) {
                              setState(() {
                                duration = value.toString();
                              });
                            },
                          ),
                          const Text(
                            "Choisissez la discipline de l'entrainement",
                            style: TextStyle(fontSize: 13),
                          ),
                          RadioListTile(
                            title: Text("Dressage"),
                            value: "Dressage",
                            groupValue: discipline,
                            onChanged: (value) {
                              setState(() {
                                discipline = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Saut d'obstacle"),
                            value: "Saut",
                            groupValue: discipline,
                            onChanged: (value) {
                              setState(() {
                                discipline = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Endurance"),
                            value: "Endurance",
                            groupValue: discipline,
                            onChanged: (value) {
                              setState(() {
                                discipline = value.toString();
                              });
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Validate will return true if the form is valid, or false if
                              // the form is invalid.
                              if (_formKey.currentState!.validate()) {
                                // Process data.
                                await Database.instance.createCours(
                                    "cours",
                                    Cours(land!, dateController.text,
                                        scheduleController.text,
                                        duration!, discipline!));
                                isFindCours();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Votre cours a bien été crée')));
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    )
                );
              }),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState`
    //isFindCours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: isFindCours(),
        builder: (BuildContext context, AsyncSnapshot<List<Cours>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, index) {
                  var land = snapshot.data?[index].getLand;
                  var date = snapshot.data?[index].getDate;
                  var schedule = snapshot.data?[index].getSchedule;
                  var duration = snapshot.data?[index].getDuration;
                  var discipline = snapshot.data?[index].getDiscipline;
                  return Card(
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Text(
                            "Cours d'équitation à venir",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Le " + date! + " à " + schedule!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Terrain d'entrainement : " + land!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Durée du cours : " + duration!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Discipline du cours : " + discipline!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
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
          onPressed: ()
            {
            isFindCours();
            },
            tooltip: "refresh list",
            backgroundColor: Colors.purple,
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: () => _formDialog(),
            tooltip: 'faire une demande de cours',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
    ],
      ),
    );
  }
}

