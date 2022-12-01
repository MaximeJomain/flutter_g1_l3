import 'package:flutter_g1_l3/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database{
  String user;
  String pwd;
  String host;
  String nameDB;
  var db;

  static Database instance = Database("test", "test", "cluster0.qhfwu3w.mongodb.net", "test");

  Database(this.user, this.pwd, this.host, this.nameDB);

  _etablishConnection() async{
    db = await Db.create("mongodb+srv://${user}:${pwd}@${host}/${nameDB}?retryWrites=true&w=majority");
    await db.open();
  }

  getCollection(String myCollec) async{
    if(db == null){
      await _etablishConnection();
      print("nouvelle connexion");
    }
    DbCollection collection = await db.collection(myCollec);
    List result = await collection.find().toList();

    return result;
  }

  pushDatainDB(String myCollec, String data) async{
    if(db == null){
      await _etablishConnection();
      print("nouvelle connexion");
    }
    // Add ligne spéfique Insert

  }

  createUser(String myCollec, User user) async{
    if(db == null){
      await _etablishConnection();
      print("nouvelle connexion");
    }
    var collection = db.collection(myCollec);
    await collection.insertOne({
      "_id": ObjectId(),
      "username": "${user.username}",
      "password": "${user.password}",
      "email": "${user.email}",
      "image": "${user.image}"
    });
}


// Ajouter fonction générique Delete / Update
}