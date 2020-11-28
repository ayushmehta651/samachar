import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:samachar/screens/firstScreen.dart';
import 'package:samachar/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 3), onDoneLoading);
  }

  //Replace the default starting screen with the orginal screen
  onDoneLoading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    print('The email is $email');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => (email == null ? LogInScreen() : FirstScreen())));
  }

  @override
  void dispose() {
    super.dispose();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(child: Image.asset('assets/images/icon.jpeg')),
      ),
    );
  }
}
