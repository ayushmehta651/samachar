import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:samachar/screens/webScreen.dart';
import 'package:samachar/Blocks/news.dart';

class CategoryScreen extends StatefulWidget {
  final String cat;

  CategoryScreen({Key key, @required this.cat}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var categories;
  bool waiting = true;

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
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.account_circle,
                size: 35,
              ))
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
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebScreen(data: categories[index].articleUrl)));
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
                                        imageUrl: categories[index].urlToImage,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    )),
                                Row(children: [
                                  Icon(Icons.share, color: Colors.blue),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 14.0),
                                    child: Icon(Icons.bookmark,
                                        color: Colors.blue),
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
}
