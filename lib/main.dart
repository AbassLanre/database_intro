import 'package:database_intro/ui/home.dart';
import 'package:database_intro/utils/databaser_helper.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

List _users;

void main() async {
  // i dont know why but this code below is important for initialization
  WidgetsFlutterBinding.ensureInitialized();
  var db = DatabaseHelper();
//  await db.saveUser( User("foli", "tyre"));
  int count = await db.getCount();
  print(count);

  //update
//    User ana = await db.getUser(1);
//    User anaUpdated = User.fromMap(
//        {"username": "updatedAna", "password": "herPassword", "id": 1});
//    await db.updateUser(anaUpdated);

//  delete
  // 0 means it delketed nothing
  // 1 means it deleted something
//    int delete= await db.deleteUser(2);
//    print("deleted foli ${delete}");

  //get a particular user
//    User ana= await db.getUser(1);
//    print("user is ${ana.username}");

  _users = await db.getAllUser();
  for (int i = 0; i < _users.length; i++) {
    User user = User.map(_users[i]);
    print("Username: ${user.username}");
  }

  List printText() {
    try {
      if (_users != null && _users.isNotEmpty) {
        return _users;
      }
    } catch (e) {
      print("null");
    }
  }

  int usersLength() {
    try {
      if (_users != null && _users.isNotEmpty) {
        return _users.length;
      } else {
        return 0;
      }
    } catch (e) {
      print("null");
    }
  }

  runApp(MaterialApp(
    title: "Database Intro",
    home: Home(),
//    home: Scaffold(
//      appBar: AppBar(
//        title: Text("DataBase"),
//        centerTitle: true,
//        backgroundColor: Colors.amberAccent,
//      ),
//      body: ListView.builder(
//          itemCount: usersLength(),
//          itemBuilder: (BuildContext context, int position){
//            return Column(
//              children: <Widget>[
//                Divider(
//                  height: 5.0,
//                ),
//                ListTile(
//                  title: Text(printText()[position]["username"]),
//
//                )
//              ],
//            );
//          }),
//  ),
  )
  );
}
