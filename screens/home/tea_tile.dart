import 'package:flutter/material.dart';
import 'package:firebase_tutorial/models/tea.dart';

class TeaTile extends StatelessWidget {
  final Tea tea;
  TeaTile({this.tea});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.amber[tea.teaStrength],
            backgroundImage: AssetImage("assets/teaIcon.png"),
          ),
          title: Text(tea.name),
          subtitle: Text("Takes ${tea.sugars} sugar(s)"),
        ),
      ),
    );
  }
}
