import 'package:database_intro/models/user.dart';
import 'package:database_intro/utils/databaser_helper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List _users;

class _HomeState extends State<Home> {
  void doSomething() async {
    WidgetsFlutterBinding.ensureInitialized();
    var db = DatabaseHelper();
    await db.saveUser(User("marley", "opo"));
    int count = await db.getCount();
    print(count);

    //update
//    User ana = await db.getUser(1);
//    User anaUpdated = User.fromMap(
//        {"username": "updatedAna", "password": "herPassword", "id": 1});
//    await db.updateUser(anaUpdated);

    //delete
//    int delete= await db.deleteUser(2);
//    print("deleted max ${delete}");

    //get a particular user
//    User ana= await db.getUser(1);
//    print("user is ${ana.username}");

    _users = await db.getAllUser();
    for (int i = 0; i < _users.length; i++) {
      User user = User.map(_users[i]);
      print("Username: ${user.username}");
    }
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


  // when you want to call doSomething call it like this so that
  // you wont have issues with it multiplying itself
  //////////////////////////////////////////////////////////////////
  bool callDoSomething;

  @override
  void initState() {
    callDoSomething = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!callDoSomething) {
      doSomething();

      callDoSomething = true;
    }
    super.didChangeDependencies();
  }
/////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    print("stop");
    return Scaffold(
      appBar: AppBar(
        title: Text("DataBase"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView.builder(
          itemCount: usersLength(),
          itemBuilder: (BuildContext context, int position) {
            return Card(
              color: Colors.grey,
              elevation: 2.0,
              child:
                ListTile(
                  title: Text(User.fromMap(_users[position]).username),
                )
            );
          }),
    );
  }
}
