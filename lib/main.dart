import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:samachar/screens/firstScreen.dart';
import 'package:samachar/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  print('The email is $email');

  runApp(MyApp(email));
}

class MyApp extends StatelessWidget {
  final String email;

  MyApp(this.email);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData.light(),
      home: (email == null ? LogInScreen() : FirstScreen()),
    );
  }
}