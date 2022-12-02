import 'package:flutter/material.dart';
import 'package:flutter_g1_l3/main.dart';
import 'package:flutter_g1_l3/tables/tableUser.dart';
import 'package:flutter_g1_l3/view/login.dart';


class MySignupPage extends StatefulWidget{
   const MySignupPage({super.key, required this.title});

  final String title;

  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pictureController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child:
            Column(
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Entrez un nom d'utilisateur",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez rentrer un nom d'utilisateur";
                    }
                    return null;
                  },
                ),
                Divider(),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Entrez un mot de passe',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez rentrer un mot de passe';
                    }
                    return null;
                  },
                ),
                Divider(),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Entrez une adresse e-mail',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez rentrer un email valide';
                    }
                    return null;
                  },
                ),
                Divider(),
                TextFormField(
                  controller: pictureController,
                  decoration: const InputDecoration(
                    hintText: "Entrez le lien d'une image",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez rentrer un lien d'image valide";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid
                      if (_formKey.currentState!.validate()) {
                        // Process data
                        MyApp.myDB.createUser("users", User(usernameController.text, passwordController.text, pictureController.text, emailController.text, "", "", ""));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(
                                'Votre compte a bien été crée')));
                      Navigator.of(context).pushNamed(LoginPage.tag);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
                  onPressed: () => Navigator.of(context).pushNamed(LoginPage.tag),
                  child: const Text("Already an account ?",
                      style: TextStyle(
                        color: Colors.grey,
                      ))),
            ])
          ),
        ],
      ),
    );
  }
}

