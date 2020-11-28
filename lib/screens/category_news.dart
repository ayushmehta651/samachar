import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:samachar/screens/webScreen.dart';
import 'package:samachar/Blocks/news.dart';
import 'package:samachar/services/crud.dart';
import 'package:share/share.dart';

class CategoryScreen extends StatefulWidget {
  final String cat;

  CategoryScreen({Key key, @required this.cat}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var categories;
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
  Set saved = Set();

  //Called only once in the lifecycle
  void initState() {
    super.initState();
    getCategory();
  }

  //Called whenever the state is removed
  @override
  void dispose() {
    super.dispose();
  }

  getCategory() async {
    CategoryNews newsInstance = CategoryNews();
    await newsInstance.getCategorie(widget.cat);
    categories = newsInstance.news;
    setState(() {
      waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: Icon(
          Icons.tab_outlined,
          color: Colors.black,
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 75),
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
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebScreen(data: categories[index].url)));
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
                                    categories[index].publishedAt == null
                                        ? "Loading.."
                                        : categories[index]
                                            .publishedAt
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(categories[index].source,
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
                                              categories[index].title == null
                                                  ? "Loading.."
                                                  : categories[index].title,
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
                                              categories[index].description ==
                                                      null
                                                  ? "Loading.."
                                                  : categories[index]
                                                      .description,
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
                                        imageUrl: categories[index].urlToImg,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    )),
                                Row(children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.share,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      Share.share(categories[index].url,
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
                                            title = (categories[index].title ==
                                                    null)
                                                ? "  "
                                                : categories[index].title;
                                            url =
                                                (categories[index].url == null)
                                                    ? "  "
                                                    : categories[index].url;
                                            source =
                                                (categories[index].source ==
                                                        null)
                                                    ? "  "
                                                    : categories[index].source;
                                            content =
                                                (categories[index].content ==
                                                        null)
                                                    ? "  "
                                                    : categories[index].content;
                                            urlToImg = (categories[index]
                                                        .urlToImg ==
                                                    null)
                                                ? "  "
                                                : categories[index].urlToImg;
                                            description = (categories[index]
                                                        .description ==
                                                    null)
                                                ? "  "
                                                : categories[index].description;
                                          });
                                          (saved.contains(
                                                  categories[index].title))
                                              ? _showSnackBar()
                                              : _saveNews();

                                          saved.add(articles[index].title);
                                          print(saved);
                                        },
                                        icon: saved.contains(
                                                categories[index].title)
                                            ? Icon(Icons.bookmark_outlined)
                                            : Icon(Icons
                                                .bookmark_outline_outlined),
                                        iconSize: 35.0,
                                      )),
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

  _showSnackBar() {
    saved.remove(title);
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.thumb_down),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text('Article Already saved'),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
