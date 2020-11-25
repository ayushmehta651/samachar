import 'package:cloud_firestore/cloud_firestore.dart';


class CrudMethods {
  Future<void> addNews(newsData) async {
    FirebaseFirestore.instance.collection("save").add(newsData).catchError((e) {
      print(e);
    });
  }

  getNewzzz() async {
    return FirebaseFirestore.instance.collection("save").snapshots();
  }
}