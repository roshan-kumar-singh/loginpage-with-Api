import 'package:untitled5/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedIn');

    // Navigate back to the login screen
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    UserModel user= ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Posts"),
      ),
      body:Container(
        child:Column(
          children: [
              Card(
                child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.status!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.name!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                   ),
                  Text(
                    user.username!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.userType!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.appUrl!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.key!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.institute!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.code!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${user.mainTeacher!}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
    Center(
    child: ElevatedButton(
    child: Text('Logout'),
    onPressed: () {
    showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
    title: Text('Confirm Logout'),
    content: Text('Are you sure you want to logout?'),
    actions: <Widget>[
    ElevatedButton(
    child: Text('Cancel'),
    onPressed: () {
    Navigator.pop(context);
    },
    ),
    ElevatedButton(
    child: Text('Yes'),
    onPressed: () {
    Navigator.pop(context);
    _logout();
    },
    ),
    ],
    );
    },
    );
    },
    ),
    ),
            ],
      ),
      ),);
  }
}
