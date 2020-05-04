//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/screens/home/settings_form.dart';
import 'package:firebase_tutorial/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_tutorial/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_tutorial/screens/home/tea_list.dart';
import 'package:firebase_tutorial/models/tea.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Tea>>.value(
      value: DatabaseService().teas,
      child: Scaffold(
        backgroundColor: Colors.brown[300],
        appBar: AppBar(
          backgroundColor: Colors.green[500],
          title: Text("TeaMinder"),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text(
                  "Logout",
                )),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            )
          ],
        ),
        body: Container(
          child: TeaList(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/tea.png"), 
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
