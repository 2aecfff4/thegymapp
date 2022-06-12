import 'package:flutter/material.dart';
import 'package:thegymapp/homepage/homepage.dart';
// import "homepage.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "The Gym App",
      theme: ThemeData.from(
          colorScheme:
              const ColorScheme.dark().copyWith(secondary: Colors.blueAccent)),
      home: const HomePage(),
    );
  }
}
