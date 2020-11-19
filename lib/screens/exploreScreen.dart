import 'package:flutter/material.dart';
import 'package:samachar/screens/category_news.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(crossAxisCount: 2, children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(cat: "business")));
                },
                child: Icon(
                  Icons.work,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Text("Business",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryScreen(cat: "sports")));
                },
                child: Icon(
                  Icons.directions_bike,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Text("Sports",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(cat: "technology")));
                },
                child: Icon(
                  Icons.smartphone,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Text("Technology",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(cat: "entertainment")));
                },
                child: Icon(
                  Icons.local_movies,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Text("Entertainment",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryScreen(cat: "health")));
                },
                child: Icon(
                  Icons.local_hospital,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Text("Health",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(cat: "Science")));
                },
                child: Icon(
                  Icons.nature_people,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Text("Science",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(cat: "General")));
                },
                child: Icon(
                  Icons.people,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Text("General",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          ),
        ),
      ]),
    );
  }
}