import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class CrudMethods {
  Future<void> addNews(String title, String description, String content,
      String urlToImg, String url, String source) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('save');
    var temp = "";
    temp = "${randomAlphaNumeric(9)}";
    print(temp);
    ref.doc(temp).set({
      "uid": temp,
      "title": title,
      "description": description,
      "urlToImg": urlToImg,
      "content": content,
      "url": url,
      "source": source
    });
  }

  Future deleteArticle(uid) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('save');
    ref
        .doc(uid)
        .delete()
        .then((value) => print("success"))
        .catchError((error) => print(error.toString()));
  }

  getNewzzz() async {
    return FirebaseFirestore.instance.collection("save").snapshots();
  }
}
