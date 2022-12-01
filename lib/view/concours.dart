import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/tables/tableConcours.dart';

import '../database.dart';

class ConcoursPage extends StatefulWidget {

  static const tag = "concours_page";

  const ConcoursPage({super.key, required this.title});

  final String title;

  @override
  State<ConcoursPage> createState() => _ConcoursPageState();
}

class _ConcoursPageState extends State<ConcoursPage> {
  static List<Concours> concoursList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: concoursList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: SizedBox(
                      width: 500,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/dancefloor.jpeg"),
                              Text(concoursList[index].getName)
                            ],
                          ),
                          // Text(eventList[index].getParticipants),
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
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => ConcoursForm(),
        ),
        tooltip: 'Ajouter un concours',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ConcoursForm extends StatefulWidget {

  // final Function callback;
  const ConcoursForm({super.key});

  @override
  ConcoursFormState createState() {
    return ConcoursFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class ConcoursFormState extends State<ConcoursForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<ConcoursFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? level;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Text("Ajouter un concours", style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold
            ),),
            Divider(),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.assignment_turned_in_outlined),
                labelText: "Nom du concours",
              ),
            ),
            TextFormField(
              controller: adressController,
              decoration: const InputDecoration(
                icon: Icon(Icons.assistant_navigation),
                labelText: "Adresse du concours",
              ),
            ),
            TextFormField(
              controller: pictureController,
              decoration: const InputDecoration(
                icon: Icon(Icons.add_photo_alternate_outlined),
                labelText: "photo du concours",
              ),
            ),
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month_outlined),
                labelText: "date du concours",
              ),
            ),
            const Text("", style: TextStyle(
                fontSize: 15
            ),),
            const Text("Choisissez votre level:", style: TextStyle(
                fontSize: 15
            ),),
            RadioListTile(
              title: Text("Amateur"),
              value: "amateur",
              groupValue: level,
              onChanged: (value){
                setState(() {
                  level = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Club 1"),
              value: "c1",
              groupValue: level,
              onChanged: (value){
                setState(() {
                  level = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Club 2"),
              value: "c2",
              groupValue: level,
              onChanged: (value){
                setState(() {
                  level = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Club 3"),
              value: "c3",
              groupValue: level,
              onChanged: (value){
                setState(() {
                  level = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Club 4"),
              value: "c4",
              groupValue: level,
              onChanged: (value){
                setState(() {
                  level = value.toString();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (nameController.text != "" && adressController.text != "" && dateController.text != ""){
                      Database.instance.createConcours("concours", Concours(nameController.text,adressController.text, pictureController.text, dateController.text, "${level}"));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                            Text("Le concours a bien été ajouté")),
                      );
                          Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                            Text("Veuillez reneigner tous les champs")),
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}