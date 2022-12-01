import 'package:flutter_g1_l3/tables/tableEvent.dart';
import 'package:flutter_g1_l3/tables/tableUser.dart';
import 'package:flutter_g1_l3/tables/tableConcours.dart';

import 'package:mongo_dart/mongo_dart.dart';

class Database {
  String user;
  String pwd;
  String host;
  String nameDB;
  var db;

  Database(this.user, this.pwd, this.host, this.nameDB);

  static Database instance =
      Database("test", "test", "cluster0.dbdsp9o.mongodb.net", "test");

  _etablishConnection() async {
    db = await Db.create(
        "mongodb+srv://${user}:${pwd}@${host}/${nameDB}?retryWrites=true&w=majority");
    await db.open();
  }

  getCollection(String myCollec) async {
    if (db == null) {
      await _etablishConnection();
    }
    DbCollection collection = await db.collection(myCollec);
    List result = await collection.find().toList();
    return result;
  }

  createUser(String myCollec, User user) async {
    if (db == null) {
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
      "username": "${concours.name}",
      "password": "${concours.adress}",
      "picture": "${concours.picture}",
      "email": "${concours.date}"
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


  updateHorseOwner(String username, String? horsename) async {
    if (db == null) {
      await _etablishConnection();
      print("nouvelle connexion");
    }
    var collection = db.collection("horses");
    await collection.update(
        where.eq('name', horsename), modify.set('owner', username));
  }

  updateUserInfo(String username, String phoneNumber, String age, String ffe) async {
    if (db == null) {
      await _etablishConnection();
      print("nouvelle connexion");
    }
    var collection = db.collection("users");
    await collection.update(
        where.eq('username', username),
        {
          r'$set': {
            'phone_number': phoneNumber,
            'age': age,
            'ffe': ffe,
          }
        }
    );
  }

  getOwnerHorses(String username) async {
    if (db == null) {
      await _etablishConnection();
      print("nouvelle connexion");
    }
    var collection = db.collection("horses");
    return await collection.find(where.eq('owner', username)).toList();

  }

}
