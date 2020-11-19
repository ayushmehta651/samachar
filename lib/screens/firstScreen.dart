import 'package:flutter/material.dart';
import 'package:samachar/screens/HomeScreen.dart';
import 'package:samachar/screens/exploreScreen.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomeScreen(
      key: PageStorageKey('Page 1'),
    ),
    ExploreScreen(key: PageStorageKey('Page 2')),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        drawer: Drawer(child: Icon(Icons.settings, size: 50)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.orange,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.view_headline, color: Colors.black, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore, color: Colors.black, size: 30),
                label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark, color: Colors.black, size: 30),
                label: 'Saved Post'),
          ],
          onTap: (index) {
            if (mounted) {
              setState(() {
                selectedIndex = index;
              });
            }
          },
          currentIndex: selectedIndex,
        ),
        body: PageStorage(bucket: bucket, child: pages[selectedIndex]),
      );
  }
}