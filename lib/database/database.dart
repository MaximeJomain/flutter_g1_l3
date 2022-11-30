import 'package:mongo_dart/mongo_dart.dart';

class Database{
  String user;
  String pwd;
  String host;
  String nameDB;
  var db;

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


  // Ajouter fonction générique Delete / Update
}