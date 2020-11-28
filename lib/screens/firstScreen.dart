import 'package:flutter/material.dart';
import 'package:samachar/screens/HomeScreen.dart';
import 'package:samachar/screens/exploreScreen.dart';
import 'package:samachar/screens/savedScreen.dart';
import 'package:samachar/screens/userDetails.dart';

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
    ExploreScreen(
      key: PageStorageKey('Page 2'),
    ),
    SavedScreen(
      key: PageStorageKey('Page 3'),
    ),
    UserDetails(
      key: PageStorageKey('Page 3'),
    )
  ];

  final PageStorageBucket bucket = PageStorageBucket();

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
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.black, size: 30),
              label: 'Account'),
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
