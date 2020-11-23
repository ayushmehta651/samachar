import 'package:flutter/material.dart';
import 'package:samachar/Blocks/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:samachar/Database/sql.dart';
import 'package:samachar/model/article_model.dart';
import 'package:samachar/screens/webScreen.dart';
import 'package:samachar/sign-in.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Article> savedArticles;
  DatabaseHelper _dbHelper;
  List<Article> articles;
  bool waiting = true;
  Article _article = Article();

  //Called only once in the lifecycle
  void initState() {
    super.initState();
    getNews();
  }

  //Called whenever the state is removed
  @override
  void dispose() {
    super.dispose();
  }

  getNews() async {
    News newsInstance = News();
    await newsInstance.getNews();
    articles = newsInstance.news;
    setState(() {
      _dbHelper = DatabaseHelper.instance;
      print('************  DATABASE CONNECTED  *************');
      waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              )
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Row(
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
      body: (waiting)
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebScreen(data: articles[index].articleUrl)));
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
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                              articles[index].publishedAt == null
                                  ? "Loading.."
                                  : articles[index]
                                  .publishedAt
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600])),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(articles[index].source,
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
                                        articles[index].title == null
                                            ? "Loading.."
                                            : articles[index].title,
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
                                        articles[index].description ==
                                            null
                                            ? "Loading.."
                                            : articles[index].description,
                                        style: TextStyle(
                                            color: Colors.grey[600]),
                                      ),
                                    )
                                  ])
                            ],
                          ),
                        ),
                        Column(children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 5.0),
                              child: SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: CachedNetworkImage(
                                  imageUrl: articles[index].urlToImage,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              )),
                          Row(children: [
                            Icon(Icons.share, color: Colors.blue,size : 30.0),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 14.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _article.title = articles[index].title;
                                    _article.articleUrl =
                                        articles[index].articleUrl;
                                    _article.content = articles[index].content;
                                    _article.description =
                                        articles[index].description;
                                    _article.source = articles[index].source;
                                  });
                                  _savedArticle();
                                },
                                child: Icon(Icons.bookmark,
                                    color: Colors.blue,
                                  size : 30.0,

                                ),
                              ),
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

  _refreshArticleList() async {
    List<Article> x = await _dbHelper.fetchArticles();
    setState(() {
      savedArticles = x;
    });
  }

  _savedArticle() async {
    await _dbHelper.insertArticle(_article);
    print(_article.title);
    _refreshArticleList();
  }
}
