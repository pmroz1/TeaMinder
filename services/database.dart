import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/models/tea.dart';
import 'package:firebase_tutorial/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference teaCollection =
      Firestore.instance.collection("tea");

  Future updateUserData(int teaStrength, String name, String sugar) async {
    return await teaCollection
        .document(uid)
        .setData({"teaStrength": teaStrength, "name": name, "sugar": sugar});
  }

  //jarls list from snapshot
  List<Tea> _teaListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Tea(
          name: doc.data['name'] ?? '',
          teaStrength: doc.data['teaStrength'] ?? 2,
          sugars: doc.data['sugars'] ?? "");
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  // get brews stream
  Stream<List<Tea>> get teas {
    return teaCollection.snapshots().map(_teaListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return teaCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
