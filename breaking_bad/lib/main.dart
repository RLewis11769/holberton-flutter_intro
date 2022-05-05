import 'package:flutter/material.dart';
import 'package:breaking_bad/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Constructor
  const MyApp({Key? key}) : super(key: key);

  // Overriding default build
  @override
  Widget build(BuildContext context) {
    // Styling using Material App
    return MaterialApp(
      // Usually wrap text in Text widget? Might be updated syntax
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Home page defined by HomeScreen widget
      home: const HomeScreen(),
    );
  }
}
