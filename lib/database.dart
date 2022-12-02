import 'package:flutter_g1_l3/tables/tableEvent.dart';
import 'package:flutter_g1_l3/tables/tableUser.dart';
import 'package:flutter_g1_l3/tables/tableConcours.dart';

import 'package:mongo_dart/mongo_dart.dart';

class Database{
  String user;
  String pwd;
  String host;
  String nameDB;
  var db;

  Database(this.user, this.pwd, this.host, this.nameDB);

  static Database instance = Database("test", "test", "cluster0.qhfwu3w.mongodb.net", "test");

  _etablishConnection() async{
    db = await Db.create("mongodb+srv://${user}:${pwd}@${host}/${nameDB}?retryWrites=true&w=majority");
    await db.open();
  }

  getCollection(String myCollec) async{
    if(db == null){
      await _etablishConnection();
    }
    DbCollection collection = await db.collection(myCollec);
    List result = await collection.find().toList();
    return result;
  }

  createUser(String myCollec, User user) async{
    if(db == null){
      await _etablishConnection();
      print("nouvelle connexion");
    }
    var collection = db.collection(myCollec);
    await collection.insertOne({
      "_id": ObjectId(),
      "username": user.username,
      "password": user.password,
    "picture": user.picture,
      "email": user.email,
      "phone":user.phone,
      "old": user.old,
      "type": user.type
    });
  }
  createConcours(String myCollec, Concours concours) async{
    if(db == null){
      await _etablishConnection();
      print("nouvelle connexion");
    }
    var collection = db.collection(myCollec);
    await collection.insertOne({
      "_id": ObjectId(),
      "name": "${concours.name}",
      "adress": "${concours.adress}",
      "picture": "${concours.picture}",
      "date": "${concours.date}",
      "level": "${concours.level}"
    });
  }

  createEvent(String myCollec, Event event) async{
    if(db == null){
      await _etablishConnection();
      print("nouvelle connexion");
    }
    var collection = db.collection(myCollec);
    await collection.insertOne({
      "_id": ObjectId(),
      "type": event.type,
      // "participants": event.participants,
      "validate": event.validate,
    });
  }

}