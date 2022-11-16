import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/AuthHelper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<FormState> InsertKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () async {
              await FirebaseauthHelper.firebaseauthHelper.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/", (route) => false);
            },
          ),
        ],
      ),
      body: Container(
        child: Image.network(
          "https://images.unsplash.com/photo-1503891617560-5b8c2e28cbf6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8c3BsYXNoJTIwc2NyZWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
          fit: BoxFit.cover,
          height: _height,
          width: _width,
        ),
      ),
    );
  }
}
