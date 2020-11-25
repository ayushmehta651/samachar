import 'package:flutter/material.dart';
import 'package:samachar/Blocks/news.dart';
import 'package:samachar/screens/webScreen.dart';
import 'package:samachar/services/crud.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool present = false;
  CrudMethods crudMethods = new CrudMethods();
  bool waiting = true;
  var articles;
  String title;
  String description;
  String urlToImg;
  var publishedAt;
  String content;
  String url;
  String source;
  List saved = [];

  @override
  void initState() {
    super.initState();
    getNews();
    getSaved();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getSaved() {
    FirebaseFirestore.instance
        .collection("save")
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((doc) {
        saved.add(doc.data()['title']);
      });
    });
  }

  getNews() async {
    News newsInstance = News();
    await newsInstance.getNews();
    articles = newsInstance.news;
    setState(() {
      waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 75.0),
                  child: Text(
                    "News",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  "App",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ),
        ),
        body: (waiting)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WebScreen(data: articles[index].url)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Card(
                        elevation: 1.25,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      timeago.format(DateTime.parse(
                                          articles[index]
                                              .publishedAt
                                              .toString())),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600])),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(articles[index].source,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.indigo[400],
                                          fontSize: 15)),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              (articles[index].title == null)
                                                  ? "Loading..."
                                                  : articles[index].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Text(
                                              (articles[index].description ==
                                                      null)
                                                  ? "Loading..."
                                                  : articles[index].description,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                            ),
                                          )
                                        ]),
                                  ),
                                  Column(children: [
                                    SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CachedNetworkImage(
                                          imageUrl: articles[index].urlToImg,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        )),
                                    Row(children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          size: 35.0,
                                        ),
                                        onPressed: () async {
                                          Share.share(articles[index].url,
                                              subject:
                                                  'Be updated with the latest news!!');
                                        },
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, right: 16.0),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                title =
                                                    (articles[index].title ==
                                                            null)
                                                        ? "  "
                                                        : articles[index].title;
                                                url = (articles[index].url ==
                                                        null)
                                                    ? "  "
                                                    : articles[index].url;
                                                source = (articles[index]
                                                            .source ==
                                                        null)
                                                    ? "  "
                                                    : articles[index].source;
                                                content = (articles[index]
                                                            .content ==
                                                        null)
                                                    ? "  "
                                                    : articles[index].content;
                                                urlToImg = (articles[index]
                                                            .urlToImg ==
                                                        null)
                                                    ? "  "
                                                    : articles[index].urlToImg;
                                                description = (articles[index]
                                                            .description ==
                                                        null)
                                                    ? "  "
                                                    : articles[index]
                                                        .description;
                                              });
                                              (saved.contains(
                                                      articles[index].title))
                                                  ? print("Already present!!!")
                                                  : _saveNews();
                                            },
                                            icon: Icon(
                                              (saved.contains(
                                                      articles[index].title))
                                                  ? Icons.bookmark_outlined
                                                  : Icons
                                                      .bookmark_outline_outlined,
                                              size: 35,
                                            ),
                                          )),
                                    ])
                                  ])
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  );
                }));
  }

  _saveNews() async {
    Map<String, dynamic> newsMap = {
      "title": title,
      "description": description,
      "urlToImg": urlToImg,
      "content": content,
      "url": url,
      "source": source
    };
    crudMethods.addNews(newsMap).then((result) {
      final snackBar = SnackBar(
        content: Row(
          children: [
            Icon(Icons.thumb_up),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text('Article saved'),
            ),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
