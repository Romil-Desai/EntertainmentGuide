import 'package:entertainmentguide/screens/home_page.dart';
import 'package:entertainmentguide/screens/search_page.dart';
import 'package:entertainmentguide/screens/test.dart';
import 'package:entertainmentguide/screens/testscrren.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
