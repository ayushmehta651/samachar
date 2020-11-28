import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addNews(newsData) async {
    FirebaseFirestore.instance.collection("save").add(newsData).catchError((e) {
      print(e);
    });
  }

  Future getNewzzz() async {
    return FirebaseFirestore.instance.collection("save").snapshots();
  }

  Future deleteArticle(String documentId) async {
    await FirebaseFirestore.instance.collection("save").doc(documentId).delete();
  }
}