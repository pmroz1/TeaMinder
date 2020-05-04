import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/models/tea.dart';
import 'package:firebase_tutorial/screens/home/tea_tile.dart';

class TeaList extends StatefulWidget {
  @override
  _TeaListState createState() => _TeaListState();
}

class _TeaListState extends State<TeaList> {
  @override
  Widget build(BuildContext context) {
    final teas = Provider.of<List<Tea>>(context) ?? [];
    // jarls.forEach((jarl) {
    //   print(jarl.name);
    //   print(jarl.tribe);
    //   print(jarl.people);
    // });

    return ListView.builder(
      itemCount: teas.length,
      itemBuilder: (context, index) {
        return TeaTile(tea: teas[index]);
      },
    );
  }
}
