import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:samachar/Database/sql.dart';
import 'package:samachar/model/article_model.dart';
import 'package:samachar/screens/webScreen.dart';

class SavedScreen extends StatefulWidget {
  SavedScreen({Key key}) : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {

  DatabaseHelper _dbHelper;
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    _refreshArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Column(
        children: [
          _articleList(),
        ],
      ),
    );
  }

  _refreshArticleList() async {
    List<Article> x = await _dbHelper.fetchArticles();
    setState(() {
      _articles = x;
    });
    print('*******************  CURRENT LIST LENGTH *****************');
    print(_articles.length);
  }

  _articleList() => Expanded(
    child: ListView.builder(
      itemCount: _articles.length,
      itemBuilder: (BuildContext context, int index) {

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WebScreen(data: _articles[index].articleUrl)));
          },
          child: Card(
            elevation: 1.25,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(_articles[index].source,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700])),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0,
                                        right: 8.0,
                                        bottom: 8.0,
                                        top: 8.0),
                                    child: Text(
                                      _articles[index].title == null
                                          ? "Loading.."
                                          : _articles[index].title,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0,
                                        right: 8.0,
                                        bottom: 8.0,
                                        top: 8.0),
                                    child: Text(
                                      _articles[index].description ==
                                          null
                                          ? "Loading.."
                                          : _articles[index].description,
                                      style: TextStyle(
                                          color: Colors.grey[600]),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ),
                      Column(children: [

                        Row(children: [
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              size : 30.0,
                              color: Colors.blue[700],
                            ),
                            onPressed: () async {
                             Share.share(_articles[index].articleUrl,
                               subject: 'Be updated with the latest news!!'
                             );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_sweep,
                              size : 30.0,
                              color: Colors.blue[700],
                            ),
                            onPressed: () async {
                              await _dbHelper.deleteArticle(_articles[index].id);
                                  _refreshArticleList();
                            },
                          ),
                        ])
                      ])
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

