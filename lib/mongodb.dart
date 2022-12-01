/*import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import 'constant.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);
    await collection.insertMany([{
      "email": "maxime.jomain@edu.itescia.fr",
      "password": "jesuisunemerde"
    },
      {
        "email": "mickael.gbaguidi@edu.itescia.fr",
        "password": "yo"
      }]);
    print(await collection.find().toList());
  }
}*/