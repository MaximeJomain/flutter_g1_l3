import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/tables/tableConcours.dart';
import '../database.dart';
import 'package:flutter_g1_l3/main.dart';


class ConcoursPage extends StatefulWidget {

  static const tag = "concours_page";

  const ConcoursPage({super.key, required this.title});

  final String title;

  @override
  State<ConcoursPage> createState() => _ConcoursPageState();
}

class _ConcoursPageState extends State<ConcoursPage> {
  List<Concours> concoursList = [];

  var participants = 0;

  Future<List<Concours>> isFindConcours() async {

    final result = await MyApp.myDB.getCollection("concours");
    for (var item in result) {
      final concours = Concours(item['name'], item['adress'], item['picture'], item['date'], item['level']);
      concoursList.add(concours);
    }
    return concoursList;
  }

  increment() {
    setState(() {
      participants++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: isFindConcours(),
        builder: (BuildContext context, AsyncSnapshot<List<Concours>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, index)  {
                  var name = snapshot.data?[index].getName;
                  var adress = snapshot.data?[index].getAdress;
                  var picture = snapshot.data?[index].getPicture;
                  var date = snapshot.data?[index].getDate;
                  var level = snapshot.data?[index].getLevel;
                  return Card(
                    child: SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              height: 120,
                              width: 120,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                              ),
                              child: Image.asset(picture!,
                                  height: 120,
                                  width: 120)
                          ),
                              Text("Compétition : ${name!}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Padding(padding: const EdgeInsets.all(5),
                              child: Text("Ville : ${adress!}")),
                          Padding(padding: const EdgeInsets.all(5),
                              child: Text("Niveau : ${level!}",
                                  style: const TextStyle(color: Colors.brown))),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(5),
                                  child: Text("Nombre de participants: ${participants}")),
                              TextButton(
                                  onPressed: () {
                                    increment();
                                  },
                                  child: Text("M'inscrire"))
                            ]
                          )
                        ],
                      ),
                    ));
                },
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
           isFindConcours();
          },
      tooltip: "refresh list",
      backgroundColor: Colors.brown,
      child: const Icon(Icons.refresh),
    ),
            FloatingActionButton(
              onPressed: ()  {
                showDialog<String>(
                  context: context,
                    builder: (BuildContext context) => const ConcoursForm(),
                );
              },
              tooltip: 'Ajouter un concours',
              child: const Icon(Icons.add),
            ),
      ],
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
                    if (nameController.text != "" && adressController.text != "" && dateController.text != "" && pictureController.text != ""){
                      MyApp.myDB.createConcours("concours", Concours(nameController.text,adressController.text, pictureController.text, dateController.text, "${level}"));
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