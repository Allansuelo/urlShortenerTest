
import 'package:flutter/material.dart';
import 'package:urlshortener/components.dart';
import 'homePage.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Url Shortener',
      theme: ThemeData(
        scaffoldBackgroundColor: Components.antiFlashWhite,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Url Shortener'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: HomePage(),
    );
  }
}
