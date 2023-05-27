// ignore_for_file: unnecessary_null_comparison
import 'package:mongo_dart/mongo_dart.dart';

class Database{
 static String dbUrl = "mongodb://brunohectre:mugamba%402580@cluster0.k6kp0b7.mongodb.net/NyumbaYo";
// static Db db =  Db(dbUrl);

  /// connect to mongoDB
  static Future<Db> connect() async {
    return await Db.create("mongodb+srv://brunohectre:mugamba%402580@cluster0.k6kp0b7.mongodb.net/NyumbaYo");
  }
  // get collection

/// inserting one record to mongoDB
  static Future<void> insertOne(String collection, Map<String, dynamic> data) async {
    var db = await connect();
    await db.open();
    await db.collection(collection).insert(data);
    db.close();
  }
/// inserting many records to mongoDB
 static Future<void> insertMany(String collection, List<Map<String, dynamic>> data) async {
    var db = await connect();
    db.open();
   await db.collection(collection).insertMany(data);
   db.close();
}
/// updating one record in mongoDB
  // Future<void> updateOne(String collection, Map<String, dynamic> data) async {
  //   await db.collection(collection).update(data);
  // }
  // fetch all records from mongoDB
  static Future<List<Map<String, dynamic>>> fetchAll(String collection) async {
    var db = await connect();
    await db.open();
    return  db.collection(collection).find().toList();
  }
}