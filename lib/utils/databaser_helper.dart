// this helps to create database, tables, delete  and update
// the base of most database apps, only few things would change
// search for things that would make it change
// know more about this, this has been the toughest for me so far cause
// everything is just too much, would need to sit and read more on this
import 'dart:async';
import 'dart:io';
import 'package:database_intro/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableUser = "userTable";
  final String columnId = "id";
  final String columnUsername = "username";
  final String columnPassword = "password";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,
        "maindb.db"); // home://directory/files/maindb.db
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  // to create a table like
  //     id | username | password
  //----------------------------------
  //      1 |  abass   | wgjgjgj
  // and so on

  // CRUD- create Read Update Delete
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnUsername TEXT, $columnPassword TEXT)");
  }

  //insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableUser", user.toMap());
    return res;
  }

  //get user
  Future<List> getAllUser() async {
    var dbClient =
        await db; // abass check if var result = await db.rawquery works
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableUser"));
  }

  Future<User> getUser(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableUser WHERE $columnId = $id");
    if (result.length == 0) {
      return null;
    } else {
      return User.fromMap(result.first);
    }
  }

  //delete
  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableUser, where: "$columnId = ?", whereArgs: [id]);
  }

  // update
  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]);
  }

  // close
  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }


}
